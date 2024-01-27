function [eigenValueRobustness, maximumEigenValues] = calculateParametersRobustness(simulationParameters, designParametersRobustness, designParametersPerturbation)
%% calculateParametersRobustnes
% Description:  This function calculates the mean value of the maximum jacobian eigen value after small design parameters perturbation. After the
%               mean value of the those eigenvalues is calculated. The mean value calculated constitutes a metric of the models robustness to small parameters deviation.
% 
% Inputs:     	simulationParameters:           simulationParameters:      struct that contains as fields
%                                               1) A struct with all the dimensional model pararameters. (Model) 
%                                               2) A struct with all the undimensional model parameters. (ModelFactors)
%                                               3) A struct that contains all the solver parameters. (Solver)
%                                               4) The section plane sturct. (sectionPlane)
%
%               designParametersRobustness:     cell that contains the name of the parameters whith which the models robustness will be checked.
%
%               designParametersPerturbation:   double value of the parameters perturbation that will be used in the robustness estimation algorithm.
%
% Outputs:      eigenValueRobustness:           double mean value of the maximum jacobian eigen value after small design parameters perturbation.
%
%               maximumEigenValues:             double array that contains the maximum jacobian eigen value after each design parameter's small perturbation.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

% Load data
parametersModelFactors  = simulationParameters.parametersModelFactors;
numOfDesignParameters   = length(designParametersRobustness);
maximumEigenValues      =  zeros(numOfDesignParameters*2 + 1, 1);

% For each parameter perturbation calculate the maximum jacobian eigen value
for iDesignParameter = 1 : numOfDesignParameters
    
    % Initialize cost functions design factors
    parametersModelFactorsFront     = parametersModelFactors;
    parametersModelFactorsBack      = parametersModelFactors;
    
    % Perturb cost function design factors
    parametersModelFactorsFront.(designParametersRobustness{iDesignParameter}) 	= parametersModelFactors.(designParametersRobustness{iDesignParameter}) + designParametersPerturbation/2;
    parametersModelFactorsBack.(designParametersRobustness{iDesignParameter})  	= parametersModelFactors.(designParametersRobustness{iDesignParameter}) - designParametersPerturbation/2;
    
    % Update parametersModelFactors base on the perturbation
    parametersModelFactorsFront = updateParametersModelFactors(parametersModelFactorsFront);
    parametersModelFactorsBack  = updateParametersModelFactors(parametersModelFactorsBack);
    
    % Generate dimensional model parameters
    parametersModelFront                 = generateParametersModel(parametersModelFactorsFront);
    parametersModelBack                 = generateParametersModel(parametersModelFactorsBack);
    
    % Generate simulation parameters structure
    simulationParametersFront               = struct;
    simulationParametersFront.Model         = parametersModelFront;
    simulationParametersFront.ModelFactors	= parametersModelFactorsFront;
    simulationParametersFront.Solver        = SimulationModelOptions.simulationParameters.Solver;
    simulationParametersFront.sectionPlane 	= SimulationModelOptions.simulationParameters.sectionPlane;
    
    jacobianFront            = generateJacobianMatrix( 	fixedPointConditions, simulationParametersFront,...
        'unconstrainedVariablesToExclude', JacobianCalculationOptions.unconstrainedVariablesToExclude);
    
    simulationParametersBack                = struct;
    simulationParametersBack.Model          = parametersModelBack;
    simulationParametersBack.ModelFactors	= parametersModelFactorsBack;
    simulationParametersBack.Solver         = SimulationModelOptions.simulationParameters.Solver;
    simulationParametersBack.sectionPlane	= SimulationModelOptions.simulationParameters.sectionPlane;
    
    jacobianBack            = generateJacobianMatrix( 	fixedPointConditions, simulationParametersBack,...
        'unconstrainedVariablesToExclude', JacobianCalculationOptions.unconstrainedVariablesToExclude);
    
    maximumEigenValues(iDesignParameter*2 -1)  = max(jacobianFront.eigenValuesNorm);
    maximumEigenValues(iDesignParameter*2)  	= max(jacobianBack.eigenValuesNorm);
end

maximumEigenValues(end) = max(Jacobian.eigenValuesNorm);
eigenValueRobustness  	= mean(maximumEigenValues);