%% Optimize four bar mechanism with extensive search
g           = 1;
aVec        = linspace(0.2,0.5,20);
bVec        = linspace(0.15,1,20);
fVec        = linspace(0.7,1.6,20);
thetaVec    = linspace(0,1,40);

% Specifications
load('results4Actuators_M06_00.mat')
thetaExtra              = 30*pi/180; % Mechanism angle span allowance
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
theta0Opt       	= theta0Vector(aOptIdx,bOptIdx,fOptIdx,thetaOptIdx);
torqueLinkVector    = torqueThetaK;

%% Visualize the resulting mechanism
grTrajectory        = zeros(1,length(torqueLinkVector));
thetaLinkVector     = results4Actuators_M06_00.thetaK + theta0Opt - min(results4Actuators_M06_00.thetaK);
for iSimulationStep = 1 : length(torqueLinkVector)
grTrajectory(iSimulationStep) = 1/dpsiFB_dthFB(aOpt,bOpt,fOpt,g,thetaLinkVector(iSimulationStep));
end
torqueMotorVector   = torqueLinkVector.*grTrajectory';
