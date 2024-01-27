function optimizeModelWithSteepestDescend(OptimizationOptions, SimulationModelOptions)
%% optimizeModelWithSteepestDescend 
% Description:  This function executes a gradient based optimization of the model parameters for a specific cost function.
% 
% Inputs:  	OptimizationOptions:	struct that contains options that can affect the optimization's performance. As fields you can find:
%                                   1) Options related to the calculation of the fixed point for each examination of
%                                   different model parameters. (FixedPointCalculationOptions)
%                                   2) Options related to the jacobian matrix calculation (JacobianCalculationOptions)
%                                   3) Options related to the cost function weights (CostFunctionOptions)
%                                   4) Options related to the steepest descend method (SteepestDescendOptions)
%                                   See RunOptimizationAlgorithm.m in order to obtain more details about each option structure.   
%
%           SimulationModelOptions 	struct that contains options that are related to the model simulation parameters and the real construction characteristics.
%                                   As fields you can find:
%   `                               1) The initial simulation paramerameters of the mode (simulationParameters)
%                                   2) The initial conditions with wich the optimization starts (initialConditions)
%                                   3) The construction characteristics that produce the construction restrictions (ConstructionCharacteristics)
%                                   See RunOptimizationAlgorithm.m in order to obtain more details about each option structure.
%
% Outputs:  The outputs are saved on the specified at the OptimizationOptions structure folder. As outputs are considered the optimization iteration mat files (iterationResults#)
%           and the final optimization information mat file (optimizationInformation).
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Main optimization options
SteepestDescendOptions          = OptimizationOptions.SteepestDescendOptions;

designFactors                   = SteepestDescendOptions.designFactors;           
optimizationName                = SteepestDescendOptions.optimizationName;
overwriteFolder                 = SteepestDescendOptions.overwriteFolder;
stepSize                        = SteepestDescendOptions.stepSize;
maxIterations                   = SteepestDescendOptions.maxIterations;
initialIteration                = SteepestDescendOptions.initialIteration;
iterationResults                = SteepestDescendOptions.iterationResults;

smallGradientNorm                       = SteepestDescendOptions.smallGradientNorm;
numOfConsequtiveSmallGradientNormMax   	= SteepestDescendOptions.numOfConsequtiveSmallGradientNormMax;
costFunctionSmallProgressRate         	= SteepestDescendOptions.costFunctionSmallProgressRate;
numOfcostFunctionSmallProgressRateMax  	= SteepestDescendOptions.numOfcostFunctionSmallProgressRateMax;

%% Initialize optimization problem

% Extract the model factors and the initial conditions of the simulation
ModelFactors                    = SimulationModelOptions.simulationParameters.ModelFactors;
initialConditions               = SimulationModelOptions.initialConditions;

% Initial optimization convergence data
OptimizationConvergenceStruct                                       = struct;

OptimizationConvergenceStruct.smallGradientNorm                     = smallGradientNorm;
OptimizationConvergenceStruct.numOfConsequtiveSmallGradientNormMax  = numOfConsequtiveSmallGradientNormMax;
OptimizationConvergenceStruct.numOfConsequtiveSmallGradientNorm     = 0;
OptimizationConvergenceStruct.isGradientConverged                   = false;

OptimizationConvergenceStruct.costFunctionSmallProgressRate         = costFunctionSmallProgressRate;
OptimizationConvergenceStruct.numOfcostFunctionSmallProgressRateMax = numOfcostFunctionSmallProgressRateMax;
OptimizationConvergenceStruct.numOfcostFunctionSmallProgressRate    = 0;
OptimizationConvergenceStruct.isCostConverged                       = false;

OptimizationConvergenceStruct.costBest                              = inf;
OptimizationConvergenceStruct.isOptimizationConverged               = false;

% Save folder
pathSave                        =  generateSaveFolder(optimizationName);

%% Perform steepest descent algorithm

for iIteration = initialIteration : maxIterations
   %%  Generate the next optimization cycle inputs
   
   	% Update parameters model factors
    if iIteration == initialIteration && isempty(fieldnames(iterationResults))
        % Continue 
    else
        designFactorsValues     = [iterationResults.designFactorsValues];
        ModelFactors  = moveParametersModelFactors(ModelFactors, designFactors, designFactorsValues, stepSize, [iterationResults.gradient]);
        ModelFactors 	= updateParametersModelFactors(ModelFactors);

    end
    
    % Update initial conditions
    [initialConditions, ~]  = updateInitialConditions(ModelFactors, initialConditions, OptimizationOptions, SimulationModelOptions, iIteration);
    
    % Calculate gradient and other metrics for current initial conditions
    iterationResults        = calculateGradient(ModelFactors, initialConditions, OptimizationOptions, SimulationModelOptions);
        % Save iteration results
    saveIterationResults(iterationResults, pathSave, iIteration, overwriteFolder, OptimizationOptions);
    
    % Check the optimization's convergence
    OptimizationConvergenceStruct = checkOptimizationConvergence(OptimizationConvergenceStruct, iterationResults);
    
    if OptimizationConvergenceStruct.isOptimizationConverged
        break
    end
    
end

% Save the optimization procedure information
optimizationInformation.numOfIterations                 = iIteration;
optimizationInformation.OptimizationConvergenceStruct 	= OptimizationConvergenceStruct;
optimizationInformation.optimizationFolder              = pathSave;
save([pathSave, filesep, 'optimizationInformation'], 'optimizationInformation');

end

function iterationResults = calculateGradient(parametersModelFactors, initialConditions, OptimizationOptions, SimulationModelOptions)

% Find design factor values
designFactors                           = OptimizationOptions.SteepestDescendOptions.designFactors;
optimizationPerturbation                = OptimizationOptions.SteepestDescendOptions.optimizationPerturbation;

numOfDesignFactors                      = length(designFactors);
iterationResults                        = struct;
iterationResults(numOfDesignFactors)    = struct();

% Generated perturbated model parameters
myCluster = parcluster('local');
parfor (iDesignFactor = 1 : numOfDesignFactors, myCluster.NumWorkers)
% for iDesignFactor = 1 : numOfDesignFactors
    % Generate new variable due to parfor loop
    SimulationModelOptionsNew   = SimulationModelOptions;
    OptimizationOptionsNew      = OptimizationOptions;

    % Initialize cost functions design factors
    parametersModelFactorsFront     = parametersModelFactors;
    parametersModelFactorsBack      = parametersModelFactors;
    
    % Perturb cost function design factors
    parametersModelFactorsFront.(designFactors{iDesignFactor}) 	= parametersModelFactors.(designFactors{iDesignFactor}) + optimizationPerturbation/2;
    parametersModelFactorsBack.(designFactors{iDesignFactor})  	= parametersModelFactors.(designFactors{iDesignFactor}) - optimizationPerturbation/2;
    
    % Update parametersModelFactors base on the perturbation
    parametersModelFactorsFront = updateParametersModelFactors(parametersModelFactorsFront);
    parametersModelFactorsBack  = updateParametersModelFactors(parametersModelFactorsBack);
    
    % Calculate cost for front perturbation
    [perturbedCostFront, functionCallDetailsFront]              = costFunctionStability(parametersModelFactorsFront, initialConditions,  OptimizationOptionsNew, SimulationModelOptionsNew, ['Finding FP for ', designFactors{iDesignFactor}, ' front...']);
    
    % Calculate cost for back perturbation
    [perturbedCostBack, functionCallDetailsBack]                = costFunctionStability(parametersModelFactorsBack, initialConditions,  OptimizationOptionsNew, SimulationModelOptionsNew, ['Finding FP for ', designFactors{iDesignFactor}, ' back...']);

    % Save results
    iterationResults(iDesignFactor).gradient                	= (perturbedCostFront - perturbedCostBack) / optimizationPerturbation;
    iterationResults(iDesignFactor).cost                        = (perturbedCostFront + perturbedCostBack) / 2;
    
 	iterationResults(iDesignFactor).eigenValueMaxGr          	= (functionCallDetailsFront.eigenValueMaxCost - functionCallDetailsBack.eigenValueMaxCost)/optimizationPerturbation;
 	iterationResults(iDesignFactor).eigenValueRobustnessGr    	= (functionCallDetailsFront.eigenValueRobustnessCost - functionCallDetailsBack.eigenValueRobustnessCost)/optimizationPerturbation;
    iterationResults(iDesignFactor).constructionGr            	= (functionCallDetailsFront.constructionCost - functionCallDetailsBack.constructionCost)/optimizationPerturbation;
    iterationResults(iDesignFactor).constructionMassGr            	= (functionCallDetailsFront.constructionMassCost - functionCallDetailsBack.constructionMassCost)/optimizationPerturbation;
    iterationResults(iDesignFactor).meanFootClearanceGr       	= (functionCallDetailsFront.meanFootClearanceCost - functionCallDetailsBack.meanFootClearanceCost)/optimizationPerturbation;
    iterationResults(iDesignFactor).minFootClearanceGr         	= (functionCallDetailsFront.minFootClearanceCost - functionCallDetailsBack.minFootClearanceCost)/optimizationPerturbation;
    
    iterationResults(iDesignFactor).eigenValueMax               = (functionCallDetailsFront.eigenValueMax + functionCallDetailsBack.eigenValueMax)/2;
    iterationResults(iDesignFactor).eigenValueRobustness    	= (functionCallDetailsFront.eigenValueRobustness + functionCallDetailsBack.eigenValueRobustness)/2;
    iterationResults(iDesignFactor).construction                = (functionCallDetailsFront.construction + functionCallDetailsBack.construction)/2;
    iterationResults(iDesignFactor).constructionMass          	= (functionCallDetailsFront.constructionMass + functionCallDetailsBack.constructionMass)/2;
    iterationResults(iDesignFactor).meanFootClearance         	= (functionCallDetailsFront.meanFootClearance + functionCallDetailsBack.meanFootClearance)/2;
    iterationResults(iDesignFactor).minFootClearance         	= (functionCallDetailsFront.minFootClearance + functionCallDetailsBack.minFootClearance)/2;
    
 	iterationResults(iDesignFactor).designFactors           	= designFactors{iDesignFactor};
    iterationResults(iDesignFactor).designFactorsValues         = parametersModelFactors.(designFactors{iDesignFactor});
    iterationResults(iDesignFactor).functionCallDetailsFront  	= functionCallDetailsFront;  
    iterationResults(iDesignFactor).functionCallDetailsBack  	= functionCallDetailsBack;  
    
end

% Save the initialConditions and the model's parameter factors (That are common for all the design variables)
iterationResults(1).parametersModelFactors    	= parametersModelFactors;
iterationResults(1).initialConditions           = initialConditions;

end

function [initialConditionsUpdated, isInitialConditionsFound] = updateInitialConditions(parametersModelFactors, initialConditions, OptimizationOptions, SimulationModelOptions, iIteration)
% Excecute try catch
try

%% Generate message
updateICMessage = sprintf(['Updating initial conditions for the optimization iteration ', num2str(iIteration), '\n']);
fprintf(updateICMessage);

%% Generate dimensional model parameters
parametersModel                 = generateParametersModel(parametersModelFactors);

%% Generate simulation parameters structure
FixedPointCalculationOptions    = OptimizationOptions.FixedPointCalculationOptions;
JacobianCalculationOptions      = OptimizationOptions.JacobianCalculationOptions;
simulationParameters            = struct;

%% Assign data to simulation parameters
simulationParameters.Model          = parametersModel;
simulationParameters.Solver         = SimulationModelOptions.simulationParameters.Solver;
simulationParameters.sectionPlane   = SimulationModelOptions.simulationParameters.sectionPlane;

[initialConditionsUpdated, ~, ~, ~, ~, isInitialConditionsFound]    = calculateFixedPointConditionsWithJacobian(    initialConditions, simulationParameters,...
    'tol',                              FixedPointCalculationOptions.tol,...
    'max_iter',                         FixedPointCalculationOptions.max_iter,...
    'displayConvergenceProgress',       FixedPointCalculationOptions.displayConvergenceProgress, ...
    'modelAlias',                       '',...
    'maximumNoProgressSteps',           FixedPointCalculationOptions.maximumNoProgressSteps,...
    'progressRateMinimum',              FixedPointCalculationOptions.progressRateMinimum, ...
    'unconstrainedVariablesToExclude',  JacobianCalculationOptions.unconstrainedVariablesToExclude,...
	'perturbation',                     JacobianCalculationOptions.perturbation);

if ~isInitialConditionsFound
    warningMessage = 'Initial condition is not found';
    warning(warningMessage);
end

catch ME
    save('errorFixedPointCalculation', 'initialConditions', 'parametersModelFactors', 'OptimizationOptions', 'SimulationModelOptions', 'iIteration')
    rethrow(ME)
end

end

function saveIterationResults(iterationResults, pathSave, iIteration, overwriteFolder, OptimizationOptions)

matName         = ['iterationResults', num2str(iIteration)];

if (iIteration == 1) && isfolder(pathSave) && overwriteFolder
    rmdir(pathSave,'s')
    mkdir(pathSave)
    
    save([pathSave,filesep,'OptimizationOptions'],'OptimizationOptions')

    
elseif (iIteration == 1) && isfolder(pathSave) && ~overwriteFolder
    errorMessage    = sprintf(  ['The folder name specified, already exists.',...
                                ' Please select a new folder name or set ''overwriteFolder'' option to false \n']);
    error(errorMessage)
    
elseif (iIteration == 1) && (~isfolder(pathSave)) 
    mkdir(pathSave)
    
end
save([pathSave, filesep, matName],'iterationResults');

end

function pathSave = generateSaveFolder(optimizationName)

pathCurrent     = pwd;
pathSave        = [pathCurrent, '\OptimizationResults\', optimizationName];

end

function parametersModelFactors = moveParametersModelFactors(parametersModelFactors, designFactors, designFactorsValues, stepSize, gradient)

    % Move model factors
    designFactorsValues	= designFactorsValues - stepSize * gradient;
    numOfDesignFactors  = length(designFactorsValues);
    
    for iDesignFactor = 1 : numOfDesignFactors
        parametersModelFactors.(designFactors{iDesignFactor})   = designFactorsValues(iDesignFactor);
        
        % Update correlated model factors
        parametersModelFactors                                  = updateParametersModelFactors(parametersModelFactors);
    end
    
end

function  OptimizationConvergenceStruct = checkOptimizationConvergence(OptimizationConvergenceStruct, iterationResults)
%% Extract data
smallGradientNorm                       = OptimizationConvergenceStruct.smallGradientNorm;
numOfConsequtiveSmallGradientNormMax    = OptimizationConvergenceStruct.numOfConsequtiveSmallGradientNormMax;
numOfConsequtiveSmallGradientNorm       = OptimizationConvergenceStruct.numOfConsequtiveSmallGradientNorm;
isGradientConverged                     = OptimizationConvergenceStruct.isGradientConverged;

costFunctionSmallProgressRate           = OptimizationConvergenceStruct.costFunctionSmallProgressRate;
numOfcostFunctionSmallProgressRateMax   = OptimizationConvergenceStruct.numOfcostFunctionSmallProgressRateMax;
numOfcostFunctionSmallProgressRate      = OptimizationConvergenceStruct.numOfcostFunctionSmallProgressRate;
isCostConverged                         = OptimizationConvergenceStruct.isCostConverged;
costBest                                = OptimizationConvergenceStruct.costBest;

%% Check gradient norm
gradient                = [iterationResults.gradient];
gradientNorm            = norm(gradient);

if gradientNorm < smallGradientNorm
    numOfConsequtiveSmallGradientNorm = numOfConsequtiveSmallGradientNorm + 1;
else
    numOfConsequtiveSmallGradientNorm = 0;
end

if numOfConsequtiveSmallGradientNorm < numOfConsequtiveSmallGradientNormMax
    % Do nothing
else
    isGradientConverged = true;
end

%% Check cost
cost                    = mean([iterationResults.cost]);

if cost > costBest - abs(costBest) * costFunctionSmallProgressRate
    numOfcostFunctionSmallProgressRate = numOfcostFunctionSmallProgressRate + 1;
else
    numOfcostFunctionSmallProgressRate = 0;
    costBest = cost;
end

if numOfcostFunctionSmallProgressRate < numOfcostFunctionSmallProgressRateMax
    % Do nothing
else
    isCostConverged = true;
end

%% Is optimization converged
isOptimizationConverged = any([isGradientConverged, isCostConverged]);

%% Assign the convergence resutls
OptimizationConvergenceStruct.smallGradientNorm                     = smallGradientNorm;
OptimizationConvergenceStruct.numOfConsequtiveSmallGradientNormMax  = numOfConsequtiveSmallGradientNormMax;
OptimizationConvergenceStruct.numOfConsequtiveSmallGradientNorm     = numOfConsequtiveSmallGradientNorm;
OptimizationConvergenceStruct.isGradientConverged                   = isGradientConverged;

OptimizationConvergenceStruct.costFunctionSmallProgressRate         = costFunctionSmallProgressRate;
OptimizationConvergenceStruct.numOfcostFunctionSmallProgressRateMax = numOfcostFunctionSmallProgressRateMax;
OptimizationConvergenceStruct.numOfcostFunctionSmallProgressRate    = numOfcostFunctionSmallProgressRate;
OptimizationConvergenceStruct.isCostConverged                       = isCostConverged;

OptimizationConvergenceStruct.costBest                              = costBest;
OptimizationConvergenceStruct.isOptimizationConverged             	= isOptimizationConverged;

end
