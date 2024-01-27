%% Load Workspace generation
clear all
% GenerateWorkSpaceGenerateWorkspaceOfOptimization2
GenerateWorkspaceOfOptimization3
% initialConditions.q         = initialConditions.q .* (1+0*(rand(1,4)-0.5));
% initialConditions.qd        = initialConditions.qd .* (1+0*(rand(1,4)-0.5));
fixedPointConditionsBest	= initialConditions;

%% Load paremeters model real
% clear all
% GenerateCadWorkSpace
% fixedPointConditionsBest	= initialConditions;

% load('C:\Projects\BipedProject\Optimization\SimulationCodes\OptimizationResults\Optimization_23_09_05\iterationResults84.mat')
% parametersModelFactorsReal          = parametersModelFactors;
% parametersModelFactorsReal.Mall     = iterationResults(1).functionCallDetailsBack.Constraints.Data.Mall*378/293;
% parametersModelFactorsReal.Lall     = 0.55;
% parametersModelFactorsReal.g        = 9.81;
% parametersModelFactorsReal          = updateParametersModelFactors(parametersModelFactorsReal);
% parametersModelReal              	= generateParametersModel(parametersModelFactorsReal);

%% Calculate fixed points
% tic
% [fixedPointConditionsBest, JacobianBest, eigenValueMaxMean, resemblanceMetricsFunctionBest, resemblanceMetricsSolutionBest, ~] = calculateFixedPointConditionsWithJacobian(fixedPointConditionsBest, simulationParameters, 'max_iter', 20, 'maximumNoProgressSteps', 5);
% toc

%% Run gait function
tic
[conditions, results]   = gaitFunction(fixedPointConditionsBest, simulationParameters, 'numOfIntersections', 1);
toc

% Plot foot clearance
% figure
results = extractFootClearance(results, simulationParameters);
% plot(results.t, results.footClearance)
% hold on
% scatter(results.t(results.footClearanceLocalMinimumIdxs), results.footClearanceLocalMinimums)
% hold off


% MinClearance trajectory figure
close all
pOpts   = loadPlotOptions;
figureMinClearance           	= pOpts.gFigure('MinClearance Plot');
figureMinClearance.Visible       = 'on';

axesMinClearance                 = pOpts.gAxes(figureMinClearance);
axesMinClearance.XGrid           = 'on';
axesMinClearance.YGrid           = 'on';
axesMinClearance.XMinorGrid      = 'on';
axesMinClearance.YMinorGrid      = 'off';
axesMinClearance.XScale         = 'linear';
axesMinClearance.YScale         = 'linear';

axesMinClearance.Title.String    = sprintf('Foot clearance local minimums');
axesMinClearance.XLabel.String   = 'Time [sec]';
axesMinClearance.YLabel.String   = 'Foot clearance [m]';

pMinClearanceMatlab            	= pOpts.gLine(axesMinClearance, results.t, results.footClearance);
sMinClearance                   = pOpts.gScatter(axesMinClearance, results.t(results.footClearanceLocalMinimumIdxs), results.footClearanceLocalMinimums);
sMinClearanceMin                = pOpts.gScatter(axesMinClearance, results.t(results.footClearanceLocalMinimumIdxs(find(results.footClearanceLocalMinimums == min(results.footClearanceLocalMinimums),2))), min(results.footClearanceLocalMinimums));

linecolors                      = pOpts.colormapFunction(1);
pMinClearanceMatlab.Color     	= linecolors(1,:);

Scattercolors                       = pOpts.colormapFunction(2);
sMinClearance.MarkerFaceColor      	= 1 - Scattercolors(1,:);
sMinClearanceMin.MarkerFaceColor  	= 1 - Scattercolors(2,:);


lMinClearance                   = legend(axesMinClearance); 
lMinClearance.Location          = 'best';
lMinClearance.String{1}         = 'Swing leg foot clearance';
lMinClearance.String{2}         = 'Foot clearance local extremums';
lMinClearance.String{3}         = 'Foot clearance global minimum';
