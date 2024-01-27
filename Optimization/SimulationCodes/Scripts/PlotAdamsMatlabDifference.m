close all
%% Generate plot options
pOpts   = loadPlotOptions;

%% Load data from matlab and Adams simulation
% Load matlab results for current robot
robotName = 'AEK_2023_09_26';
robotFolder = [pwd, filesep, 'RobotDesigns', filesep, robotName];
load([robotFolder,'\results'])

% Load data from adams file
robotNameAdams = 'AdamsModel19_LowStiffnesKnees';
robotFolderAdams = ['C:\Projects\BipedProject\SimulationsAdams\SimulationIteration2\Adams', filesep, robotNameAdams];

load([robotFolderAdams,'\timeSimulation.txt'])
load([robotFolderAdams,'\xSimulation.txt'])
load([robotFolderAdams,'\ySimulation.txt'])
load([robotFolderAdams,'\zSimulation.txt'])
load([robotFolderAdams,'\thetaFSimulation.txt'])
load([robotFolderAdams,'\thetaTSimulation.txt'])
load([robotFolderAdams,'\psiFSimulation.txt'])
load([robotFolderAdams,'\psiTSimulation.txt'])
load([robotFolderAdams,'\thetaClearanceSimulation.txt'])
load([robotFolderAdams,'\psiClearanceSimulation.txt'])

    % Discard the first steps from the adams simulation
    timeSimulation = timeSimulation(14956:end);
    xSimulation = xSimulation(14956:end);
    ySimulation = ySimulation(14956:end);
    zSimulation = zSimulation(14956:end);
    thetaFSimulation = thetaFSimulation(14956:end);
    thetaTSimulation = thetaTSimulation(14956:end);
    psiFSimulation = psiFSimulation(14956:end);
    psiTSimulation = psiTSimulation(14956:end);
    thetaClearanceSimulation = thetaClearanceSimulation(14956:end);
    psiClearanceSimulation = psiClearanceSimulation(14956:end);
    
    % Convert radians to degrees
    thetaFSimulation = thetaFSimulation*180/pi-180;
    thetaTSimulation = thetaTSimulation*180/pi-180;
    psiFSimulation = psiFSimulation*180/pi+180;
    psiTSimulation = psiTSimulation*180/pi+180;
    
 	% Invert z axis
    zSimulation = -zSimulation;
    
    % Consider current z position as 0 
    zSimulation = zSimulation - (zSimulation(1)-results.xH(1)); %zSimulation - results.xH(1) |||  zSimulation - zSimulation(1)
    
    % Consider current time as 0
    timeSimulation = timeSimulation - timeSimulation(1);
    
%% Compare data
% Hip trajectory figure
figureHip           	= pOpts.gFigure('Hip Plot');
figureHip.Visible       = 'on';

axesHip                 = pOpts.gAxes(figureHip);
axesHip.XGrid           = 'on';
axesHip.YGrid           = 'on';
axesHip.XMinorGrid      = 'on';
axesHip.YMinorGrid      = 'on';
axesHip.Title.String    = sprintf('Hip Trajectory Comparison');
axesHip.XLabel.String   = 'Distance covered at x direction [m]';
axesHip.YLabel.String   = 'Distance covered at z direction [m]';

pHipMatlab            	= pOpts.gLine(axesHip, results.xH, results.yH);
pHipAdams               = pOpts.gLine(axesHip, zSimulation, ySimulation);

linecolors            	= pOpts.colormapFunction(2);
pHipMatlab.Color        = linecolors(1,:);
pHipAdams.Color         = linecolors(2,:);

lHip                   = legend(axesHip); 
lHip.Location          = 'best';
lHip.String{1}         = 'Matlab Simulation';
lHip.String{2}         = 'Adams Simulation';

% Femoral angle figure
figureFemoral           	= pOpts.gFigure('Femoral Plot');
figureFemoral.Visible       = 'on';

axesFemoral                 = pOpts.gAxes(figureFemoral);
axesFemoral.XGrid           = 'on';
axesFemoral.YGrid           = 'on';
axesFemoral.XMinorGrid      = 'on';
axesFemoral.YMinorGrid      = 'on';
axesFemoral.Title.String    = sprintf('Femoral angle comparison');
axesFemoral.XLabel.String   = 'Time [sec]';
axesFemoral.YLabel.String   = 'Femoral angle [deg]';

pFemoralMatlab            	= pOpts.gLine(axesFemoral, results.t, results.thetaF*180/pi);
pFemoralAdams               = pOpts.gLine(axesFemoral, timeSimulation, thetaFSimulation);

linecolors            	= pOpts.colormapFunction(2);
pFemoralMatlab.Color        = linecolors(1,:);
pFemoralAdams.Color         = linecolors(2,:);

lFemoral                   = legend(axesFemoral); 
lFemoral.Location          = 'best';
lFemoral.String{1}         = 'Matlab Simulation';
lFemoral.String{2}         = 'Adams Simulation';

% Outer femoral angle figure
figureFemoralOuter           	= pOpts.gFigure('FemoralOuter Plot');
figureFemoralOuter.Visible       = 'on';

axesFemoralOuter                 = pOpts.gAxes(figureFemoralOuter);
axesFemoralOuter.XGrid           = 'on';
axesFemoralOuter.YGrid           = 'on';
axesFemoralOuter.XMinorGrid      = 'on';
axesFemoralOuter.YMinorGrid      = 'on';
axesFemoralOuter.Title.String    = sprintf('Outer femoral angle comparison');
axesFemoralOuter.XLabel.String   = 'Time [sec]';
axesFemoralOuter.YLabel.String   = 'Outer femoral angle [deg]';

pFemoralOuterMatlab            	= pOpts.gLine(axesFemoralOuter, results.t, results.thetaF*180/pi);
pFemoralOuterAdams               = pOpts.gLine(axesFemoralOuter, timeSimulation, thetaFSimulation);

linecolors            	= pOpts.colormapFunction(2);
pFemoralOuterMatlab.Color        = linecolors(1,:);
pFemoralOuterAdams.Color         = linecolors(2,:);

lFemoralOuter                   = legend(axesFemoralOuter); 
lFemoralOuter.Location          = 'best';
lFemoralOuter.String{1}         = 'Matlab Simulation';
lFemoralOuter.String{2}         = 'Adams Simulation';


% Inner femoral angle figure
figureFemoralInner           	= pOpts.gFigure('FemoralInner Plot');
figureFemoralInner.Visible       = 'on';

axesFemoralInner                 = pOpts.gAxes(figureFemoralInner);
axesFemoralInner.XGrid           = 'on';
axesFemoralInner.YGrid           = 'on';
axesFemoralInner.XMinorGrid      = 'on';
axesFemoralInner.YMinorGrid      = 'on';
axesFemoralInner.Title.String    = sprintf('Inner femoral angle comparison');
axesFemoralInner.XLabel.String   = 'Time [sec]';
axesFemoralInner.YLabel.String   = 'Inner femoral angle [deg]';

pFemoralInnerMatlab            	= pOpts.gLine(axesFemoralInner, results.t, results.psiF*180/pi);
pFemoralInnerAdams               = pOpts.gLine(axesFemoralInner, timeSimulation, psiFSimulation);

linecolors            	= pOpts.colormapFunction(2);
pFemoralInnerMatlab.Color        = linecolors(1,:);
pFemoralInnerAdams.Color         = linecolors(2,:);

lFemoralInner                   = legend(axesFemoralInner); 
lFemoralInner.Location          = 'best';
lFemoralInner.String{1}         = 'Matlab Simulation';
lFemoralInner.String{2}         = 'Adams Simulation';

% Outer tibial angle figure
figureTibialOuter           	= pOpts.gFigure('TibialOuter Plot');
figureTibialOuter.Visible       = 'on';

axesTibialOuter                 = pOpts.gAxes(figureTibialOuter);
axesTibialOuter.XGrid           = 'on';
axesTibialOuter.YGrid           = 'on';
axesTibialOuter.XMinorGrid      = 'on';
axesTibialOuter.YMinorGrid      = 'on';
axesTibialOuter.Title.String    = sprintf('Outer tibial angle comparison');
axesTibialOuter.XLabel.String   = 'Time [sec]';
axesTibialOuter.YLabel.String   = 'Outer tibial angle [deg]';

pTibialOuterMatlab            	= pOpts.gLine(axesTibialOuter, results.t, results.thetaT*180/pi);
pTibialOuterAdams               = pOpts.gLine(axesTibialOuter, timeSimulation, thetaTSimulation);

linecolors            	= pOpts.colormapFunction(2);
pTibialOuterMatlab.Color        = linecolors(1,:);
pTibialOuterAdams.Color         = linecolors(2,:);

lTibialOuter                   = legend(axesTibialOuter); 
lTibialOuter.Location          = 'best';
lTibialOuter.String{1}         = 'Matlab Simulation';
lTibialOuter.String{2}         = 'Adams Simulation';


% Inner tibial angle figure
figureTibialInner           	= pOpts.gFigure('TibialInner Plot');
figureTibialInner.Visible       = 'on';

axesTibialInner                 = pOpts.gAxes(figureTibialInner);
axesTibialInner.XGrid           = 'on';
axesTibialInner.YGrid           = 'on';
axesTibialInner.XMinorGrid      = 'on';
axesTibialInner.YMinorGrid      = 'on';
axesTibialInner.Title.String    = sprintf('Inner tibial angle comparison');
axesTibialInner.XLabel.String   = 'Time [sec]';
axesTibialInner.YLabel.String   = 'Inner tibial angle [deg]';

pTibialInnerMatlab            	= pOpts.gLine(axesTibialInner, results.t, results.psiT*180/pi);
pTibialInnerAdams               = pOpts.gLine(axesTibialInner, timeSimulation, psiTSimulation);

linecolors            	= pOpts.colormapFunction(2);
pTibialInnerMatlab.Color        = linecolors(1,:);
pTibialInnerAdams.Color         = linecolors(2,:);

lTibialInner                   = legend(axesTibialInner); 
lTibialInner.Location          = 'best';
lTibialInner.String{1}         = 'Matlab Simulation';
lTibialInner.String{2}         = 'Adams Simulation';

% Foot clearance comparison
figureFootClearance           	= pOpts.gFigure('FootClearance Plot');
figureFootClearance.Visible       = 'on';

axesFootClearance                 = pOpts.gAxes(figureFootClearance);
axesFootClearance.XGrid           = 'on';
axesFootClearance.YGrid           = 'on';
axesFootClearance.XMinorGrid      = 'on';
axesFootClearance.YMinorGrid      = 'on';
axesFootClearance.Title.String    = sprintf('Foot clearance comparison');
axesFootClearance.XLabel.String   = 'Time [sec]';
axesFootClearance.YLabel.String   = 'Foot clearance [m]';

pFootClearanceMatlab            	= pOpts.gLine(axesFootClearance, results.t, results.footClearance);
pFootOuterClearanceAdams         	= pOpts.gLine(axesFootClearance, timeSimulation, thetaClearanceSimulation);
pFootInnerClearanceAdams           	= pOpts.gLine(axesFootClearance, timeSimulation, psiClearanceSimulation);

linecolors                          = pOpts.colormapFunction(3);
pFootClearanceMatlab.Color       	= linecolors(1,:);
pFootOuterClearanceAdams.Color    	= linecolors(2,:);
pFootInnerClearanceAdams.Color    	= linecolors(3,:);

lFootClearance                   = legend(axesFootClearance); 
lFootClearance.Location          = 'best';
lFootClearance.String{1}         = 'Matlab Simulation';
lFootClearance.String{2}         = 'Adams outer foot';
lFootClearance.String{3}         = 'Adams inner foot';






