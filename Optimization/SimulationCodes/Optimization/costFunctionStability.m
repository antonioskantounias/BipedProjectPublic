function [cost, functionCallDetails] = costFunctionStability(parametersModelFactors, initialConditions,  OptimizationOptions, SimulationModelOptions, modelAlias)
%% costFunctionStability
% Description:  This function executes the calculations needed to calculate the optimization's cost function value.
% 
% Inputs:     	parametersModelFactors:	struct that contains all the non-dimentional parameters related to the robots model. As fields you can find.
%                                       1) The dimensional total mass, height and gravity accelaration. (Respectively, Mall, Lall, g)
%                                       2) The non-dimensional femoral and tibial link masses. (Respectively, mFFactor, mTFactor. Note: mHFactor
%                                       is implied by the relation mHFactor = 1 - 2*(mFFactor+mTFactor))
%                                       3) The non-dimensional femoral link, tibial link and hip mass moment of inertia. (Respectively, IFFactor, ITFactor)
%                                       4) The non-dimensional femoral link, tibial link and hip mass moment of inertia. (Respectively, IFFactor, ITFactor)
%                                       5) The non-dimensional femoral link length. (LFFactor, Note: LTFactor is implied by the relation LTFactor = 1 - LFFactor)
%                                       6) The non-dimensional femoral and tibial link's longitudinal center of mass (lFFactor, lTFactor)
%                                       7) The non-dimensional femoral link's transverse center of mass (lTxFactor)
%                                       8) The four bar link lengths. See four bar bar link section at 
%                                       explanations presentation (C:\Projects\BipedProject\Reports\Explanations.pptx). (l1, l2, l3, l4, l5, l6, ksiF, ksiT)
%                                       9) The non-dimensional rotational spring stiffness and damping at the knee cup. (kFactor, bFactor)
%                                       10) The footshape's file folder path (footShapePath)
%                                       11) The foot's half arc angle in [rad] (er)
%                                       12) The foot's non dimensional radius. (footsizeFactor)
%                                       To create a parametersModelFactors struct use the script "GenerateWorkSpace.m".
%
%               initialConditions:  	struct in the same form of state conditions used to initialize the
%                                       search for the fixed point conditions.
%
%               OptimizationOptions: 	struct that contains options that can affect the optimization's performance. As fields you can find:
%                                       1) Options related to the calculation of the fixed point for each examination of
%                                       different model parameters. (FixedPointCalculationOptions)
%                                       2) Options related to the jacobian matrix calculation (JacobianCalculationOptions)
%                                       3) Options related to the cost function weights (CostFunctionOptions)
%                                       4) Options related to the steepest descend method (SteepestDescendOptions)
%                                       See RunOptimizationAlgorithm.m in order to obtain more details about each option structure.
%
%               SimulationModelOptions:	struct that contains options that are related to the model simulation parameters and the real construction characteristics.
%                                       As fields you can find:
%   `                                   1) The initial simulation paramerameters of the mode (simulationParameters)
%                                       2) The initial conditions with wich the optimization starts (initialConditions)
%                                       3) The construction characteristics that produce the construction restrictions (ConstructionCharacteristics)
%                                       See RunOptimizationAlgorithm.m in order to obtain more details about each option structure.
%
%               modelAlias:             char that specifies the name of the model of which the fixed point is calculated.
%
% Outputs:      cost:                   double that indicates the cost-function's value. The cost depends on the cost function options.
%
%               functionCallDetails:  	struct that contains all the cost function call data that has been collected during the cost function call
%                                       this structure is usefull for troubleshooting problems during the optimization. As fields you can find:
%                                       1) The fixepoint conditions that has bee calculate for the parameters of the specific cost function call.   (fixePointConditions)
%                                       2) The model's parameter factors that correspond to the specific cost function call.                        (parametersModelFactors)
%                                       3) The return map's Jacobian                                                                                (Jacobian)
%                                       5) The convergence to the fixed point information.                                                         	(resemblanceMetricsSolution, resemblanceMetricsFunction)
%                                       6) The simulation results after a simple function call                                                   	(results)
%                                       7) The construction constraints information                                                                 (ConstraintsDifference, RobotLegs)
%                                       8) The eigen values of each parameter used at the robustness test.                                          (maximumEigenValues)
%                                       9) The maximum absolute eigen value of the Jacobian                                                         (eigenValueMax).
%                                       10) The mean eigen value after the robustness test.                                                         (eigenValueRobustness)
%                                       11) The deviation from the nominal construction summary metric.                                         	(Construction)
%                                       12) The mean foot clearance after a simple function call.                                                   (meanFootClearance)
%                                       13) The minimum foot clearance after a simple function call.                                                (minFootClearance)
%                                       14) The "eigenValueMax" cost at the cost function.                                                          (eigenValueCost)
%                                       15) The "eigenValueRobustness" cost at the cost function.                                                   (eigenValueRobustnessCost)
%                                       16) The "construction" cost at the cost function.                                                           (constructionCost)
%                                       17) The "meanFootClearance" cost at the cost function.                                                      (meanFootClearanceCost)
%                                       18) The "minFootClearance" cost at the cost function.                                                       (minFootClearanceCost)    
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

% Excecute try catch
try

%% Extract optimization options
FixedPointCalculationOptions            = OptimizationOptions.FixedPointCalculationOptions;
JacobianCalculationOptions              = OptimizationOptions.JacobianCalculationOptions;

evaluateEigenValueMax                	= OptimizationOptions.CostFunctionOptions.evaluateEigenValueMax;
eigenValueMaxPenaltyFactor              = OptimizationOptions.CostFunctionOptions.eigenValueMaxPenaltyFactor;

evaluateEigenValueRobustness            = OptimizationOptions.CostFunctionOptions.evaluateEigenValueRobustness;
eigenValueRobustnessPenaltyFactor       = OptimizationOptions.CostFunctionOptions.eigenValueRobustnessPenaltyFactor;
eigenValueRobustnessVariablePerturbation= OptimizationOptions.CostFunctionOptions.eigenValueRobustnessVariablePerturbation;

evaluateConstruction                    = OptimizationOptions.CostFunctionOptions.evaluateConstruction;
constructionPenaltyFactor              	= OptimizationOptions.CostFunctionOptions.constructionPenaltyFactor;

evaluateMeanFootClearance           	= OptimizationOptions.CostFunctionOptions.evaluateMeanFootClearance;
meanFootClearancePenaltyFactor      	= OptimizationOptions.CostFunctionOptions.meanFootClearancePenaltyFactor;

evaluateMinFootClearance                = OptimizationOptions.CostFunctionOptions.evaluateMinFootClearance;
minFootClearancePenaltyFactor           = OptimizationOptions.CostFunctionOptions.minFootClearancePenaltyFactor;

evaluateConstructionMass                = OptimizationOptions.CostFunctionOptions.evaluateConstructionMass;
constructionMassPenaltyFactor           = OptimizationOptions.CostFunctionOptions.constructionMassPenaltyFactor;
constructionMassDesired                 = OptimizationOptions.CostFunctionOptions.constructionMassDesired;
%% Generate dimensional model parameters
parametersModelFactors       	= updateParametersModelFactors(parametersModelFactors);
parametersModel                 = generateParametersModel(parametersModelFactors);

%% Generate simulation parameters structure
simulationParameters                = struct;
simulationParameters.Model          = parametersModel;
simulationParameters.Solver         = SimulationModelOptions.simulationParameters.Solver;
simulationParameters.sectionPlane   = SimulationModelOptions.simulationParameters.sectionPlane;

%% Calculate fixed point using the return map jacobian and the maximum eigen value of it.
[fixedPointConditions, Jacobian, eigenValueMaxMean, resemblanceMetricsFunction, resemblanceMetricsSolution]    = calculateFixedPointConditionsWithJacobian(    initialConditions, simulationParameters,...
    'tol',                              FixedPointCalculationOptions.tol,...
    'max_iter',                         FixedPointCalculationOptions.max_iter,...
    'displayConvergenceProgress',       FixedPointCalculationOptions.displayConvergenceProgress, ...
    'maximumNoProgressSteps',           FixedPointCalculationOptions.maximumNoProgressSteps,...
    'progressRateMinimum',              FixedPointCalculationOptions.progressRateMinimum, ...
    'unconstrainedVariablesToExclude',  JacobianCalculationOptions.unconstrainedVariablesToExclude,...
    'perturbation',                     JacobianCalculationOptions.perturbation,...
    'modelAlias',                       modelAlias);

eigenValueMax                                   = eigenValueMaxMean;
functionCallDetails.fixedPointConditions        = fixedPointConditions;
functionCallDetails.resemblanceMetricsFunction 	= resemblanceMetricsFunction;
functionCallDetails.resemblanceMetricsSolution 	= resemblanceMetricsSolution;
functionCallDetails.parametersModelFactors      = parametersModelFactors;
functionCallDetails.Jacobian                    = Jacobian;
functionCallDetails.eigenValueMax               = eigenValueMax;

%% Calculate mean and minimum foot clearance
[~, results]        = gaitFunction(initialConditions, simulationParameters);
results             = extractFootClearance(results, simulationParameters);
meanFootClearance   = results.footMeanClearance(end);
minFootClearance 	= min(results.footClearanceLocalMinimums);

functionCallDetails.results             = results;
functionCallDetails.meanFootClearance   = meanFootClearance;
functionCallDetails.minFootClearance    = minFootClearance;

%% Calculate construction penalties
% Load construction characteristics
ConstructionCharacteristics             = SimulationModelOptions.ConstructionCharacteristics;
ConstructionParameters                  = ConstructionCharacteristics.ConstructionParameters;

% Collapse construction characteristics data
crossSectionDataFemoral                 	= ConstructionCharacteristics.crossSectionDataFemoral;
crossSectionDataTibial                      = ConstructionCharacteristics.crossSectionDataTibial;
materialNameFemoral                         = ConstructionCharacteristics.materialNameFemoral;
materialNameTibial                          = ConstructionCharacteristics.materialNameTibial;

% Update LFFactor and mHFactor parameter in construction parameters and update construction characteristics
ConstructionParameters.LFFactor                     = parametersModelFactors.LFFactor;
ConstructionParameters.mHFactor                     = parametersModelFactors.mHFactor;
ConstructionCharacteristics.ConstructionParameters  = ConstructionParameters;

% Generate constraints related to construction characteristics
[Constraints, RobotLegs] = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionCharacteristics);

% Calculate penalty due to violation of constraints related to construction
ConstraintsNames = Constraints.Names;
numOfConstraints = length(ConstraintsNames);
constraintsToExclude  = {'-'};
numOfConstraintsExcluded = 0;
designFactors = OptimizationOptions.SteepestDescendOptions.designFactors;
for iConstraint = 1:numOfConstraints
   if  ~any(strcmp(designFactors, ConstraintsNames{iConstraint}))
       numOfConstraintsExcluded = numOfConstraintsExcluded + 1;
       constraintsToExclude{numOfConstraintsExcluded} = ConstraintsNames{iConstraint};
   end
end

ConstructionParametersGains = ConstructionCharacteristics.ConstructionParametersGains;
[construction, ConstraintsDifference]          	= compareConstraintsWithFactors(Constraints, parametersModelFactors, 1, 'constraintsToExclude', constraintsToExclude,'ConstructionParametersGains',ConstructionParametersGains);

functionCallDetails.Constraints               	= Constraints;
functionCallDetails.RobotLegs                   = RobotLegs;
functionCallDetails.construction                = construction;
functionCallDetails.ConstraintsDifference       = ConstraintsDifference;

%% Calculate construction mass difference from the desired
constructionMass                      = abs(Constraints.Data.Mall - constructionMassDesired);
functionCallDetails.constructionMass  = constructionMass;

%% Calculate stability robustness
if evaluateEigenValueRobustness
    designParametersRobustness                  = OptimizationOptions.SteepestDescendOptions.designFactors;
    designParametersPerturbation                = eigenValueRobustnessVariablePerturbation;
    [eigenValueRobustness, maximumEigenValues]  = calculateParametersRobustness(simulationParameters, designParametersRobustness, designParametersPerturbation);
   
else
    eigenValueRobustness                        = 0;
    maximumEigenValues                          = [];
end

functionCallDetails.eigenValueRobustness    = eigenValueRobustness;
functionCallDetails.maximumEigenValues      = maximumEigenValues;

%% Generate cost function
eigenValueMaxCost           = evaluateEigenValueMax         * eigenValueMax * eigenValueMaxPenaltyFactor;
eigenValueRobustnessCost    = evaluateEigenValueRobustness 	* eigenValueRobustness * eigenValueRobustnessPenaltyFactor;
constructionCost            = evaluateConstruction          * construction^2  * constructionPenaltyFactor;
constructionMassCost        = evaluateConstructionMass      * constructionMass^1.1 * constructionMassPenaltyFactor;
meanFootClearanceCost       = evaluateMeanFootClearance     * (-meanFootClearance) * meanFootClearancePenaltyFactor;
minFootClearanceCost        = evaluateMinFootClearance      * (1/minFootClearance) * minFootClearancePenaltyFactor;

cost =      eigenValueMaxCost +...
            eigenValueRobustnessCost +...
            constructionCost +...
            constructionMassCost +...
            meanFootClearanceCost +...
            minFootClearanceCost;

functionCallDetails.eigenValueMaxCost           = eigenValueMaxCost;       
functionCallDetails.eigenValueRobustnessCost	= eigenValueRobustnessCost;       
functionCallDetails.constructionCost            = constructionCost;
functionCallDetails.constructionMassCost        = constructionMassCost;
functionCallDetails.meanFootClearanceCost       = meanFootClearanceCost;     
functionCallDetails.minFootClearanceCost        = minFootClearanceCost;   
functionCallDetails.cost                        = cost;

catch ME
    % Save the workspace in order to be possible the error reproduction
    save('errorCostFunction', 'parametersModelFactors', 'initialConditions', 'OptimizationOptions', 'SimulationModelOptions', 'modelAlias')
    rethrow(ME)
    
end

end
