%% Load Workspace generation
clear all
% GenerateWorkSpaceGenerateWorkspaceOfOptimization2
GenerateWorkspaceOfOptimization3
% initialConditions.q         = initialConditions.q .* (1+0*(rand(1,4)-0.5));
% initialConditions.qd        = initialConditions.qd .* (1+0*(rand(1,4)-0.5));
fixedPointConditionsBest    	= initialConditions;

% Jacobian perturbation invastigation
perturbationExponent = linspace(-1,-10,20);
perturbations = 10.^(perturbationExponent);
eigenValueMaxes      = zeros(1,length(perturbationExponent));

for iPerturbation = 1 : length(perturbationExponent)
    disp(iPerturbation)
    perturbation = perturbations(iPerturbation);
    
    unconstrainedVariablesToExclude = {'thetaK'; 'thetaK_d'};
    % unconstrainedVariablesToExclude = {'-'};
    jacobian            	= generateJacobianMatrix(fixedPointConditionsBest, simulationParameters, 'unconstrainedVariablesToExclude', unconstrainedVariablesToExclude,'perturbation', perturbation);
    eigenValueMaxes(iPerturbation) = jacobian.eigenValueMax;

end

% Jacobian trajectory figure
close all
pOpts   = loadPlotOptions;
figureJacobian           	= pOpts.gFigure('Jacobian Plot');
figureJacobian.Visible       = 'on';

axesJacobian                 = pOpts.gAxes(figureJacobian);
axesJacobian.XGrid           = 'on';
axesJacobian.YGrid           = 'on';
axesJacobian.XMinorGrid      = 'on';
axesJacobian.YMinorGrid      = 'off';
axesJacobian.XScale         = 'log';
axesJacobian.YScale         = 'log';

axesJacobian.Title.String    = sprintf('Max Jacobian Eig. vs Numerical Perturbation');
axesJacobian.XLabel.String   = 'Numerical Perturbation';
axesJacobian.YLabel.String   = 'Maximum Jacobian Eigen Value';

pJacobianMatlab            	= pOpts.gLine(axesJacobian, perturbations, eigenValueMaxes);

linecolors            	= pOpts.colormapFunction(1);
pJacobianMatlab.Color        = linecolors(1,:);

lFemoral                   = legend(axesJacobian); 
lFemoral.Location          = 'best';
lFemoral.String{1}         = 'AH Poincare Map Jacobian';