% Description:  This script generates the workspace for the a robots gait simulation to run.
%               First the fixed points are calculated (this is optional and then the robot gait simulation begins.
% 
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Load Workspace generation
clear all
close all

%% Load paremeters model real
GenerateCadWorkSpaceActive
fixedPointConditionsBest	= initialConditions;

%% Calculate fixed points
tic
[fixedPointConditionsBest, JacobianBest, eigenValueMaxMean, resemblanceMetricsFunctionBest, resemblanceMetricsSolutionBest, ~] = calculateFixedPointConditionsWithJacobian(fixedPointConditionsBest, simulationParameters, 'max_iter', 20, 'maximumNoProgressSteps', 5);
toc

%% Run gait function
tic
[conditions, results]   = gaitFunction(fixedPointConditionsBest, simulationParameters, 'numOfIntersections', 1);
toc

%% Plots
parameters  = simulationParameters.Model;
footshape   = simulationParameters.Model.footshape;

% Plot foot clearance
figure
results = extractFootClearance(results, simulationParameters);
plot(results.t, results.footClearance)
hold on
scatter(results.t(results.footClearanceLocalMinimumIdxs), results.footClearanceLocalMinimums)
hold off

% Plot phase plane
plot_phase_plane(results,1)

% Find Lagrange multipliers - GRFs
results = decode_lagrange_multipliers(parameters,footshape,results,1);

%% Animation
% Find Lagrange multipliers - GRFs
results = decode_lagrange_multipliers(parameters,footshape,results,0);

figIDAnimation = prepare_animation(parameters);
plot_misc.plot_step=0.05;
mov = plot_animation(figIDAnimation,parameters,footshape,results,plot_misc);
