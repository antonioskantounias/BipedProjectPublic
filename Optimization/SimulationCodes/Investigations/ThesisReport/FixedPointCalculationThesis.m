%% Load Workspace generation
clear all
% GenerateWorkSpaceGenerateWorkspaceOfOptimization2
GenerateWorkspaceOfOptimization3
initialConditions.q         = initialConditions.q .* (1+0.3*(rand(1,4)-0.5));
initialConditions.qd        = initialConditions.qd .* (1+0.3*(rand(1,4)-0.5));
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
tic
[fixedPointConditionsBest, JacobianBest, eigenValueMaxMean, resemblanceMetricsFunctionBest, resemblanceMetricsSolutionBest, ~, differenceMaxSolutionVector] = calculateFixedPointConditionsWithJacobianThesis(fixedPointConditionsBest, simulationParameters, 'max_iter', 30, 'maximumNoProgressSteps', 5);
toc

% FixedPoint trajectory figure
close all
pOpts   = loadPlotOptions;
figureFixedPoint           	= pOpts.gFigure('FixedPoint Plot');
figureFixedPoint.Visible       = 'on';

axesFixedPoint                 = pOpts.gAxes(figureFixedPoint);
axesFixedPoint.XGrid           = 'on';
axesFixedPoint.YGrid           = 'on';
axesFixedPoint.XMinorGrid      = 'on';
axesFixedPoint.YMinorGrid      = 'off';
axesFixedPoint.XScale         = 'linear';
axesFixedPoint.YScale         = 'log';

axesFixedPoint.Title.String    = sprintf('Newton-Raphson convergence visualization');
axesFixedPoint.XLabel.String   = 'Iteration';
axesFixedPoint.YLabel.String   = 'G_{AH}';

pFixedPointMatlab            	= pOpts.gLine(axesFixedPoint, 1:length(differenceMaxSolutionVector), differenceMaxSolutionVector);

linecolors            	= pOpts.colormapFunction(1);
pFixedPointMatlab.Color        = linecolors(1,:);

% lFemoral                   = legend(axesFixedPoint); 
% lFemoral.Location          = 'best';
% lFemoral.String{1}         = 'AH Poincare Map FixedPoint';