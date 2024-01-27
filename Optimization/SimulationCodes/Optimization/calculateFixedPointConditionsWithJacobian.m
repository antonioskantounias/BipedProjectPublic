function [fixedPointConditionsBest, JacobianBest, eigenValueMaxMean, resemblanceMetricsFunctionBest, resemblanceMetricsSolutionBest, isStateConverged] = calculateFixedPointConditionsWithJacobian(initialConditions, simulationParameters, varargin)
%% calculateFixedPointConditionsWithJacobian 
% Description:  This function calculates the fixed point conditions for a specific model.
%               From a state conditions set as initialization condition a Newton Raphson (N.R.) iterative procedure
%               is implemented in order to find the system's fixed point conditions.
% 
% Inputs:       initialConditions:              struct in the same form of state conditions used to initialize the
%                                               search for the fixed point conditions.
%
%               simulationParameters:           simulationParameters:      struct that contains as fields
%                                               1) A struct with all the dimensional model pararameters. (Model) 
%                                               2) A struct with all the undimensional model parameters. (ModelFactors)
%                                               3) A struct that contains all the solver parameters. (Solver)
%                                               4) The section plane sturct. (sectionPlane)
%
% Outputs:      fixedPointConditionsBest:       struct in the same form of state conditions that aditionally constitutes the 
%                                               the fixed point condtion for the specific simulation model. Best means that
%                                               the current results correspond to the best result that the algorith has found throught
%                                               the iterations.
%
%               JacobianBest:                   struct that contains the jacobian matrix of the linearized return map. (Matrix)
%                                               Apart from that this structure also contains
%                                               1) The symbolic representation of jacobian.(Symbolic)
%                                               2) The eigen values vector of the jacobian matrix. (eigenValues)
%                                               3) The norm vector of the eigen values vector. (eigenValuesNorm)
%                                               4) The maximum from the norm of eigen values vector which is also considered
%                                               as a metric of the system's stability. (eigenValueMax)
%                                               5) The not-constrained-by-the-section-plane variables that are differentiatiad (partialDerivatives)
%                                               6) The not-constrained-by-the-section-plane variables that are not differentiated (partialDerivativeExcluded)
%                                               Best means that the current results correspond to the best result that the algorith has found throught the iterations.
%                                               In order to have a better understanding of the section plane structure read: C:\Projects\BipedProject\Reports\SectionPlane.docx            
%             
%               resemblanceMetricsFunctionBest:	struct in the same form of resemblance metrics. In this variable the compared states are the conditions before 
%                                               the return map function call (stateConditions) and conditions after the return map function call P(stateConditions).
%                                               At the fixed point the difference between those tow state conditions mast be near to 0.    
%                                               Best means that the current results correspond to the best result that the algorith has found throught the iterations.
%
%               resemblanceMetricsSolutionBest: struct in the same form of resemblance metrics. In this variable the compared states are the conditions before 
%                                               the newton raphson (n)^th iteration (stateConditions) and conditions calculated after the (n)^th iterations (stateConditionsNew).
%                                               At the fixed point the difference between those tow state conditions mast be near to 0.
%
%               isStateConverged:               logical that acts as flag in order the user to know if the fixed point is found with an acceptable level of accuracy.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Parameters
p = inputParser;
p.KeepUnmatched = true;

p.addParameter('tol', 1e-9);                                                % The tolerance of that indicates that the newton raphson method is converged
p.addParameter('max_iter', 20);                                             % Maximum N.R. iterations
p.addParameter('displayConvergenceProgress', true);                         % Flag that indicates the convergence progress of N.R. method.
p.addParameter('modelAlias', '');                                           % The model alias is printed whe the convergence progress is displayed.
p.addParameter('maximumNoProgressSteps', 5);                                % The maximum number of step that the N.R. convergence need to have progressed.
p.addParameter('progressRateMinimum', 0.3);                                 % The minimum progress that must happen after maximumNoProgressSteps.

p.parse(varargin{:})
max_iter                        = p.Results.max_iter;
tol                             = p.Results.tol;
modelAlias                      = p.Results.modelAlias;
displayConvergenceProgress    	= p.Results.displayConvergenceProgress;
progressRateMinimum             = p.Results.progressRateMinimum;
maximumNoProgressSteps        	= p.Results.maximumNoProgressSteps;

%% Implement Newton Raphson Iteration
% Initialize important variables
sectionPlane                = simulationParameters.sectionPlane;
fixedPointConditions        = sectionPlane.moveConditionsOnSectionPlane(initialConditions, simulationParameters.Model);
fixedPointConditionsBest    = fixedPointConditions;
bestDifferenceFunction      = inf;
maximumStateDifference      = inf;

eigenValueMaxBestVector     = ones(1,maximumNoProgressSteps)*2;
differenceMaxBestVector     = ones(1,maximumNoProgressSteps)*inf;

isStateConverged            = false;
iIteration                  = 1;
noProgressIterations        = 0;

% Calculate conditions after gait function call
conditionsGaitFunction   	= fixedPointConditions;
conditionsGaitFunction    	= gaitFunction(conditionsGaitFunction, simulationParameters);

% Iterative procedure
while ~isStateConverged
    %% Calculations
    % Calculate jacobian
  	jacobian                                    = generateJacobianMatrix(   fixedPointConditions, simulationParameters, varargin{:});

    partialDerivatives                          = jacobian.partialDerivatives;
    numOfPartialDerivatives                     = length(partialDerivatives);
    
    % Calculate fixed point 
        % Transform fixed point conditions
    vectorBasedOnJacobianFixedPoint             =   transformConditions2VectorBasedOnJacobian(fixedPointConditions, jacobian, sectionPlane);
    
    [vectorBasedOnJacobianGaitFunction,...
  	vectorBasedOnJacobianGaitFunctionExcluded]	=   transformConditions2VectorBasedOnJacobian(conditionsGaitFunction, jacobian, sectionPlane);
    
        % Apply newton raphson formula
  	vectorBasedOnJacobianFixedPointNew          =   (vectorBasedOnJacobianFixedPoint'  + ...
                                                    (eye(numOfPartialDerivatives) - jacobian.Matrix) \...
                                                    (vectorBasedOnJacobianGaitFunction - vectorBasedOnJacobianFixedPoint)')';

        % Decode vector based on jacobian
    fixedPointConditionsNew                     = transformVectorBasedOnJacobian2Conditions(vectorBasedOnJacobianFixedPointNew, vectorBasedOnJacobianGaitFunctionExcluded,...
                                                    jacobian, sectionPlane, simulationParameters); 

    % Calculate conditions after gait function call
    conditionsGaitFunction                      = fixedPointConditionsNew;
    conditionsGaitFunction                      = gaitFunction(conditionsGaitFunction, simulationParameters);
    
    %% Convergence control
    % Check if the fixed point function is converged
    [isStateConvergedFunction, resemblanceMetricsFunction]      = compareStateConditions(fixedPointConditionsNew, conditionsGaitFunction, 'criterionResemblance', tol);
    differenceMaxFunction                                       = resemblanceMetricsFunction.DifferenceRelative.Maximum;
    
    [isStateConvergedSolution, resemblanceMetricsSolution]  	= compareStateConditions(fixedPointConditionsNew, fixedPointConditions,'criterionResemblance', tol);
    differenceMaxSolution                                       = resemblanceMetricsSolution.DifferenceRelative.Maximum;
    
    isStateConverged                                            = isStateConvergedFunction;
    
    % Keep the mean maximum eigen value of the best fixed point approaches
    [maxDifferenceMaxBestVector,maxIDx] = max(differenceMaxBestVector);
    if differenceMaxFunction < maxDifferenceMaxBestVector
        differenceMaxBestVector(maxIDx) = differenceMaxFunction;
        if jacobian.eigenValueMax < 2
            eigenValueMaxBestVector(maxIDx) = jacobian.eigenValueMax;
        end
    end
    
    eigenValueMaxMean = mean(eigenValueMaxBestVector);
    
    % Keep the until now best solution
    if differenceMaxFunction < bestDifferenceFunction
        JacobianBest                    = jacobian;
        fixedPointConditionsBest        = fixedPointConditionsNew;
        bestDifferenceFunction          = differenceMaxFunction;
        resemblanceMetricsFunctionBest 	= resemblanceMetricsFunction;
        resemblanceMetricsSolutionBest 	= resemblanceMetricsSolution;
        differenceMaxFunctionBest       = differenceMaxFunction;
        differenceMaxSolutionBest       = differenceMaxSolution;
    end
   
    % Check if iterations are exceeding maximum iterations limit
    if ~isStateConverged
        if iIteration > max_iter
            maxIterationsMessage = sprintf(['Newton raphson iterations have exceeded maximum iterations limit = ', num2str(max_iter), '\n',... 
                'Maximum solution difference is max( x_(k) - x_(k+1) ) = ', num2str(differenceMaxFunctionBest), '\n', ...
                'Maximum function value is max( p(x_(k+1)) - x_(k+1) ) = ',  num2str(differenceMaxSolutionBest), '\n']);
            fprintf(maxIterationsMessage);
            return
        end
    end
    
    % Check if the simulation has stopped progressing
    if ~isStateConverged
        if resemblanceMetricsFunction.DifferenceRelative.Maximum > maximumStateDifference * (1 - progressRateMinimum)
            noProgressIterations = noProgressIterations + 1;
        else
            noProgressIterations = 0;
            maximumStateDifference = resemblanceMetricsFunction.DifferenceRelative.Maximum;
        end
        
        
        if noProgressIterations >= maximumNoProgressSteps
            % Display that there is no progress
            noProgressMessage = sprintf(['Newton raphson iterations has stopped progressing', '\n',...
                'Maximum solution difference is max( x_(k) - x_(k+1) ) = ', num2str(differenceMaxFunctionBest), '\n', ...
                'Maximum function value is max( p(x_(k+1)) - x_(k+1) ) = ',  num2str(differenceMaxSolutionBest), '\n\n']);
            fprintf(noProgressMessage);
            return
            
        end
    end

    %% Preparation for next step
    % Convergence progress message
    if displayConvergenceProgress
        printConvergenceProgressMessage(iIteration, modelAlias, resemblanceMetricsFunction) 
    end
    
    % Update iteration values
    fixedPointConditions        	= fixedPointConditionsNew;
    iIteration                      = iIteration + 1;
    
end

end

function [vectorBasedOnJacobian, vectorBasedOnJacobianExcluded] = transformConditions2VectorBasedOnJacobian(stateConditions, Jacobian, sectionPlane)
%% transformConditions2VectorBasedOnJacobian 
% Description:  This function takes as input the stateConditions of a system and generates the a
%               variables vector based on the Jacobian's variable sequence. The jacobian in generated
%               with the functionality to exclude and consider constant some state variables. As a result
%               2 vectors are generated, the one with the included to Jacobian's calculation variables
%               and the one with excluded to Jacobians calculation variables.
%               For the description of the input and output variables, see VariableDescriptions.m
% 
% Inputs:       stateConditions:
%               Jacobian:
%               sectionPlane:
%
% Outpus:       vectorBasedOnJacobian: 
%               vectorBasedOnJacobianExcluded:
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

partialDerivatives              = Jacobian.partialDerivatives;
partialDerivativesExcluded      = Jacobian.partialDerivativesExcluded;

variablesUnconstraintVector     = sectionPlane.transformConditions2UnconstrainedVariablesVector(stateConditions);
variablesUnconstraint           = sectionPlane.VariablesUnconstrained;

numOfPartialDerivatives         = length(partialDerivatives);
numOfPartialDerivativesExcluded = length(partialDerivativesExcluded);
vectorBasedOnJacobian           = zeros(1, numOfPartialDerivatives);
vectorBasedOnJacobianExcluded   = zeros(1, numOfPartialDerivativesExcluded);

% Take the variablesUnconstraintVector and generate the vector based on jacobian
for iPartialDerivative = 1 : numOfPartialDerivatives
    
    % For current partial derivative find the corresponding index at uncostrained variables of the section plane
    index  	= convertCharsToStrings(variablesUnconstraint) == partialDerivatives{iPartialDerivative};
    if any(index)
        vectorBasedOnJacobian(iPartialDerivative)                   = variablesUnconstraintVector(index);
    end
    
end

for iPartialDerivativeExcluded = 1 : numOfPartialDerivativesExcluded
    
    % For current partial derivative excluded find the corresponding index at uncostrained variables of the section plane
    index	= convertCharsToStrings(variablesUnconstraint) == partialDerivativesExcluded{iPartialDerivativeExcluded};
    if any(index)
        vectorBasedOnJacobianExcluded(iPartialDerivativeExcluded)	= variablesUnconstraintVector(index);
    end
    
end

end

function stateConditions = transformVectorBasedOnJacobian2Conditions(vectorBasedOnJacobian, vectorBasedOnJacobianExcluded, Jacobian, sectionPlane, simulationParameters)
%% transformVectorBasedOnJacobian2Conditions 
% Description:  This function takes as input the variable vectors that are generated based on jacobian
%               (see transformConditions2VectorBasedOnJacobian description) and using the functions
%               related to the section plane generates the conditions assuming that the systems 
%               state conditions are on the section plane.
%               For the description of the input and output variables, see VariableDescriptions.m
% 
% Inputs:       vectorBasedOnJacobian:
%               vectorBasedOnJacobianExcluded:
%               Jacobian:
%               sectionPlane:
%               simulationParameters:
%
% Outpus:       stateConditions:
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

partialDerivatives              = Jacobian.partialDerivatives;
numOfPartialDerivatives         = length(partialDerivatives);
partialDerivativesExcluded      = Jacobian.partialDerivativesExcluded;
numOfPartialDerivativesExcluded = length(partialDerivativesExcluded);

variablesUnconstraint           = sectionPlane.VariablesUnconstrained;
variablesUnconstraintVector     = zeros(1,length(variablesUnconstraint));

% Rebuild the variablesUnconstraintVector as it is defined at the section plane generation script
for iPartialDerivative = 1 : numOfPartialDerivatives
    
    % For current partial derivative find the corresponding index at uncostrained variables vector of the section plane
    index                                       = convertCharsToStrings(variablesUnconstraint) == partialDerivatives{iPartialDerivative};
    % Assign the value at unconstrained variables vector
    variablesUnconstraintVector(index)          = vectorBasedOnJacobian(iPartialDerivative);
    
end

for iPartialDerivativeExcluded = 1 : numOfPartialDerivativesExcluded
    
    % For current partial derivative excluded find the corresponding index at uncostrained variables vector of the section plane
    index                                       = convertCharsToStrings(variablesUnconstraint) == partialDerivativesExcluded{iPartialDerivativeExcluded};
    % Assign the value at unconstraine variables vector
    variablesUnconstraintVector(index)          = vectorBasedOnJacobianExcluded(iPartialDerivativeExcluded);
    
end

% Transform the unconstrained variables vector to conditions
stateConditions  = sectionPlane.transformUnconstrainedVariablesVector2Conditions(variablesUnconstraintVector, simulationParameters.Model);

end

function printConvergenceProgressMessage(iIteration, modelAlias, resemblanceMetricsFunction)  
%% printConvergenceProgressMessage 
% Description:  This function prints the convergence process message
% 
% Inputs:	iIteration:                 integer number tha specifies the iterative method's iteration index.
%
%        	modelAlias:                 char that specifies the name of the model of which the fixed point is calculated.
%
%           resemblanceMetricsFunction:	resemblanceMetricsFunctionBest:	struct in the same form of resemblance metrics. In this variable the compared states are the conditions before 
%                                     	the return map function call (stateConditions) and conditions after the return map function call P(stateConditions).
%                                    	At the fixed point the difference between those tow state conditions mast be near to 0.  
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

% Load the difference data
DifferenceRelative  = resemblanceMetricsFunction.DifferenceRelative;
fieldNames          = fieldnames(DifferenceRelative);
numOfFields         = length(fieldNames);

% Generate message
message     = ['iteration', num2str(iIteration),' ', modelAlias,'\n', 'p(x_(k+1)) - x_(k+1) = ', '\n'];
for iField = 1 : numOfFields
    fieldName   = fieldNames{iField};
    fieldValue  = DifferenceRelative.(fieldName);
    message   	= [message, fieldName, blanks(12 - length(fieldName)), '|',  blanks(10), num2str(fieldValue), '\n'];
end
message     = [message, '\n\n'];

% Print message
fprintf(message)

end
