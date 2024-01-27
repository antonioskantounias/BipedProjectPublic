%% Optimize four bar mechanism with extensive search
g           = 1;
aVec        = 0.5;
bVec        = 0.15;
fVec        = linspace(0.7,1.6,200);
thetaVec    = linspace(0,1,400);

% Specifications
load('results4Actuators_M06_00.mat')
thetaExtra              = 10*pi/180; % Mechanism angle span allowance
thetaSingularity        = 0*pi/180; % Minimum angle distance from singularities
dThetaMin               = (max(results4Actuators_M06_00.thetaK) - min(results4Actuators_M06_00.thetaK)) + thetaExtra; % Minimum mechanism angle span
torqueThetaK            = results4Actuators_M06_00.torqueThetaK;

% Initializations
torqueMotorMaxVector    = inf(length(aVec),length(bVec), length(fVec), length(thetaVec));
theta0Vector            = nan(length(aVec),length(bVec), length(fVec), length(thetaVec));
grMaxVector             = nan(length(aVec),length(bVec), length(fVec), length(thetaVec));
grMinVector             = nan(length(aVec),length(bVec), length(fVec), length(thetaVec));

% Begin extensive search
for iA = 1:length(aVec)
    a = aVec(iA);
    for iB = 1:length(bVec)
        b = bVec(iB);
        for iF = 1:length(fVec)
            f = fVec(iF);
            % Check if the mechanism exists
            if a + b + f < g
                continue
            end
            
            % Generate the 4 bar mechanism info
            FourBarMech = calculate4BarMechanism(a,b,g,f);
            FBThetaMax  = FourBarMech.ThetaMax - thetaSingularity;
            FBThetaMin  = FourBarMech.ThetaMin + thetaSingularity;
            
            % Check if the 4 bar mechanism span (away from singularities) satisfies the span specification 
            if FBThetaMax - FBThetaMin < dThetaMin
                continue
            end
            
            % Calculate the initial angle of the mechanism
            for iThetaVec = 1:length(thetaVec)
               thetaRatio  = thetaVec(iThetaVec);
               theta0       = FBThetaMin + (FBThetaMax-FBThetaMin)*thetaRatio;
               
               % Check if the span of the mechanism from the initial angle satisfies the span specification
               if FBThetaMax - theta0 < dThetaMin
                   continue    
               end
               
               % Calculate the offset angle in ordrer theta0 to correspond to the lower limit of the mechanisms trajectory
               thetaOffset = theta0 - min(results4Actuators_M06_00.thetaK);
               
               % Initialize the reduction ratio and torques
               torqueLinkVector    = torqueThetaK';
               torqueMotorVector   = zeros(1,length(torqueLinkVector));
               grVector            = zeros(1,length(torqueLinkVector));
               
               % Input link angle trajectory
               thetaLinkVector     = results4Actuators_M06_00.thetaK + thetaOffset;
               
               % Calculate the output (motors) link torque and the corresponding reduction ratio of the mechanism
               for iSimulationStep = 1 : length(torqueLinkVector)
                   gr = 1/dpsiFB_dthFB(a,b,f,g,thetaLinkVector(iSimulationStep));
                   torqueMotorVector(iSimulationStep) = torqueLinkVector(iSimulationStep) * gr;
                   grVector(iSimulationStep) = gr;
               end
               
               % Assign the value that will be used to the optimization
               torqueMotorMax                           = max(torqueMotorVector);
               torqueMotorMaxVector(iA,iB,iF,iThetaVec) = torqueMotorMax;
               theta0Vector(iA,iB,iF,iThetaVec)         = theta0;
               grMaxVector(iA,iB,iF,iThetaVec)          = max(grVector);
               grMinVector(iA,iB,iF,iThetaVec)          = min(grVector);
               
            end
        end
    end
end

%% Find the based solution from the extensive search
torquesResulted = zeros(length(fVec),length(thetaVec));
for iF = 1:length(fVec)
    for iTheta = 1:length(thetaVec)
        if isinf(torqueMotorMaxVector(1,1,iF,iTheta))
            torquesResulted(iF,iTheta) = nan;
        else
            torquesResulted(iF,iTheta) = torqueMotorMaxVector(1,1,iF,iTheta);
        end
    end
end
% If reduction ratio > 10 or < 0.1 then then the mechanism is near to singularity and the reflected inertias are high
torqueMotorMaxVector(grMaxVector>10)    = inf;
torqueMotorMaxVector(grMinVector<0.1)   = inf;

% The thet0 angles must be between pi/2 and pi 
torqueMotorMaxVector(theta0Vector<pi/2) = inf;
torqueMotorMaxVector(theta0Vector>pi)   = inf;

% Find the mechanism that produces the minimum motor torque and the corresponding mechanism characteristics
minMaxTorque                            = min(min(min(min((torqueMotorMaxVector)))));
optimumId                               = find(torqueMotorMaxVector == minMaxTorque);  
optimumId                               = optimumId(1);
[aOptIdx,bOptIdx,fOptIdx,thetaOptIdx]   = ind2sub(size(torqueMotorMaxVector), optimumId);
aOpt                = aVec(aOptIdx);
bOpt                = bVec(bOptIdx);
fOpt                = fVec(fOptIdx);
thetaOpt            = thetaVec(thetaOptIdx);
theta0Opt       	= theta0Vector(aOptIdx,bOptIdx,fOptIdx,thetaOptIdx);
torqueLinkVector    = torqueThetaK;

%% Figures generation

% Reduction ratio in the application
grTrajectory        = zeros(1,length(torqueLinkVector));
thetaLinkVector     = results4Actuators_M06_00.thetaK + theta0Opt - min(results4Actuators_M06_00.thetaK);

for iSimulationStep = 1 : length(torqueLinkVector)
grTrajectory(iSimulationStep) = dpsiFB_dthFB(aOpt,bOpt,fOpt,g,thetaLinkVector(iSimulationStep));
end

% Reduction ratio general
FourBarMech = calculate4BarMechanism(aOpt,bOpt,g,fOpt);
theta4Bar           = linspace(FourBarMech.ThetaMin,FourBarMech.ThetaMax,200);
grTrajectoryFull    = zeros(1,length(theta4Bar));

for iSimulationStep = 1 : length(theta4Bar)
grTrajectoryFull(iSimulationStep) = dpsiFB_dthFB(aOpt,bOpt,fOpt,g,theta4Bar(iSimulationStep));
end

%%% Generate figure
pOpts                         	= loadPlotOptions;
figureReductionRatio              = pOpts.gFigure('Reduction ratio angle');
figureReductionRatio.Visible      = 'on';

axesReductionRatio                = pOpts.gAxes(figureReductionRatio);
axesReductionRatio.XGrid          = 'on';
axesReductionRatio.YGrid          = 'on';
axesReductionRatio.XMinorGrid     = 'on';
axesReductionRatio.YMinorGrid     = 'off';
axesReductionRatio.XScale         = 'linear';
axesReductionRatio.YScale         = 'linear';
axesReductionRatio.YLim           = [0,12];

axesReductionRatio.Title.String   = sprintf('Mechanism angle vs Reduction ratio');
axesReductionRatio.XLabel.String  = 'Ange[rad]';
axesReductionRatio.YLabel.String  = 'Reduction ratio';

kneeMotorLegend = legend(axesReductionRatio);
kneeMotorLegend.Location = 'best';
% Add lines
mechanimsCapabilitiesLine           = pOpts.gLine(axesReductionRatio,theta4Bar,grTrajectoryFull);
kneeMotorLegend.String{end}         = 'Reduction capabilities';
mechanimsCapabilitiesLine.Color     = pOpts.LineColor(5,:);

mechanimsKneeLineOffset           	= pOpts.gLine(axesReductionRatio,thetaLinkVector,grTrajectory);
kneeMotorLegend.String{end}         = sprintf('Reduction during the knee operation');
mechanimsKneeLineOffset.Color      	= pOpts.LineColor(2,:);

mechanimsKneeLine                   = pOpts.gLine(axesReductionRatio,results4Actuators_M06_00.thetaK,grTrajectory);
kneeMotorLegend.String{end+1}      	= '';
kneeMotorLegend.String{end}         = sprintf('Reduction during the knee operation \n(Offset included)');
mechanimsKneeLine.Color             = pOpts.LineColor(1,:);

%% Joint torque - Reduction ratio
figureKneeTorque              = pOpts.gFigure('Knee torque');
figureKneeTorque.Visible      = 'on';

%%% Joint torque
tiledKneeTorqueReductionRatio 	= pOpts.gTiledLayout(figureKneeTorque, [2,1]);      
axesKneeTorque                  = pOpts.gTileAxes(tiledKneeTorqueReductionRatio, 1, [1,1]);

axesKneeTorque.XGrid          = 'on';
axesKneeTorque.YGrid          = 'on';
axesKneeTorque.XMinorGrid     = 'on';
axesKneeTorque.YMinorGrid     = 'off';
axesKneeTorque.XScale         = 'linear';
axesKneeTorque.YScale         = 'linear';
axesKneeTorque.YLim             = [-0.1,0.7];

axesKneeTorque.Title.String   = sprintf('Knee Torque vs Angle');
%axesKneeTorque.XLabel.String  = 'Ange[rad]';
axesKneeTorque.YLabel.String  = 'Knee torque [Nm]';

% Add lines
mechanimsTorqueLine           = pOpts.gLine(axesKneeTorque,results4Actuators_M06_00.thetaK,results4Actuators_M06_00.torqueThetaK);
mechanimsTorqueLine.Color     = pOpts.LineColor(1,:);

%%% Reduction ratio
axesKneeReductionRation                  = pOpts.gTileAxes(tiledKneeTorqueReductionRatio, 2, [1,1]);

axesKneeReductionRation.XGrid          = 'on';
axesKneeReductionRation.YGrid          = 'on';
axesKneeReductionRation.XMinorGrid     = 'on';
axesKneeReductionRation.YMinorGrid     = 'off';
axesKneeReductionRation.XScale         = 'linear';
axesKneeReductionRation.YScale         = 'linear';

axesKneeReductionRation.Title.String   = sprintf('Knee 4-Bar reduction ratio vs Angle');
axesKneeReductionRation.XLabel.String  = 'Joint angle[rad]';
axesKneeReductionRation.YLabel.String  = 'Reduction Ratio';

% Add lines
mechanimsTorqueLine           = pOpts.gLine(axesKneeReductionRation,results4Actuators_M06_00.thetaK,grTrajectory);
mechanimsTorqueLine.Color     = [0,0,0];

%% 
figureMechanismOptimization  = pOpts.gFigure('4 Bar Optimization');
figureMechanismOptimization.Visible      = 'on';

axesFBOptimization                = pOpts.gAxes(figureMechanismOptimization);
axesFBOptimization.XGrid          = 'off';
axesFBOptimization.YGrid          = 'off';
axesFBOptimization.XMinorGrid     = 'off';
axesFBOptimization.YMinorGrid     = 'off';
axesFBOptimization.XScale         = 'linear';
axesFBOptimization.YScale         = 'linear';

axesFBOptimization.Title.String   = sprintf('Four bar optimization');
axesFBOptimization.XLabel.String  = 'Non-dimensional offset angle θ_{offset}^{*}';
axesFBOptimization.YLabel.String  = 'Non-dimensional floating link length f^{*}';
axesFBOptimization.Color = [0.3,0.3,0.3];
axesFBOptimization.Colormap = pink;

[OptimizationFBM, OptimizationFBContour] = contourf(axesFBOptimization, thetaVec, fVec, torquesResulted, 10);
OptimizationFBContour.ShowText = true;

OptimizationFBClabel    = clabel(OptimizationFBM,OptimizationFBContour,'Color',[204,229,255]/255,'FontSize',15);
OptimizationFBColorbar  = colorbar(axesFBOptimization);
OptimizationFBColorbar.Label.String = 'Max motor torque [Nm]';

OptimumPointScatter             = pOpts.gScatter(axesFBOptimization,thetaOpt,fOpt,1);
OptimumPointScatter.SizeData  = 60;
OptimumPointScatter.MarkerFaceColor = [255,153,153]/255;

OptimumPointText                = text(axesFBOptimization,thetaOpt,1.15,sprintf('Optimum linkage \nconfiguration'));
OptimumPointText.FontSize       = 15;
OptimumPointText.Color          = [255,153,153]/255;