function Jacobian = generateJacobianMatrix(stateConditions, simulationParameters, varargin)
%% generateJacobianMatrix 
% Description:  This function calculates numerically the jacobian of the descrete return map of the biped system. 
%               For each column of the jacobian matrix one of the state variables is perturbated back and front by dxi/2.
%               As a result the column ( P(x+dxi/2) - P(x-dxi/2) ) / dxi is calculated for each variable forming the jacobian matrix.
% 
% Inputs:   stateConditions:        struct that contains the reduced robot's state in the form of
%                                   1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                   2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%
%           perturbation:           double value that is used as state variable's perturbation in the numerical calculation
%                                   of the biped retun map's jacobian matrix.
%
%         	simulationParameters:  	struct that contains as fields
%                                	1) A struct with all the dimensional model pararameters. (Model) 
%                                 	2) A struct with all the undimensional model parameters. (ModelFactors)
%                                  	3) A struct that contains all the solver parameters. (Solver)
%                                	4) The section plane sturct. (sectionPlane)
%
% Outputs:  Jacobian:               struct that contains the jacobian matrix of the linearized return map. (Matrix)
%                                   Apart from that this structure also contains
%                                   1) The symbolic representation of jacobian.(Symbolic)
%                                   2) The eigen values vector of the jacobian matrix. (eigenValues)
%                                   3) The norm vector of the eigen values vector. (eigenValuesNorm)
%                                   4) The maximum from the norm of eigen values vector which is also considered
%                                   as a metric of the system's stability. (eigenValueMax)
%                                   5) The not-constrained-by-the-section-plane variables that are differentiatiad (partialDerivatives)
%                                   6) The not-constrained-by-the-section-plane variables that are not differentiated (partialDerivativeExcluded)
%                                   In order to have a better understanding of the section plane structure read: C:\Projects\BipedProject\Reports\SectionPlane.docx
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Parameters
p               = inputParser;
p.KeepUnmatched = true;

p.addParameter('unconstrainedVariablesToExclude', {'thetaK'; 'thetaK_d'});  % State variables that are considered constant and are excluded from the jacobian calculation process.
p.addParameter('perturbation', 1e-4);                                       % The state variable perturbation in order to calculate the numerically the jacobian.

p.parse(varargin{:})
unconstrainedVariablesToExclude	= p.Results.unconstrainedVariablesToExclude;
perturbation                    = p.Results.perturbation;

%% Generate function calls
% Initialize variables
conditionsFunctionCalls               	= generateFunctionCallConditions(stateConditions, perturbation, simulationParameters);
conditionsAfterFunctionCalls            = conditionsFunctionCalls; 
sectionPlane                            = simulationParameters.sectionPlane;
variablesUnconstrained              	= sectionPlane.VariablesUnconstrained;
numOfUnconstrainedVariablesToExclude    = length(unconstrainedVariablesToExclude);

% Generate the variables with wich the gait function will be called
partialDerivatives              = variablesUnconstrained;
partialDerivativesExcluded      = cell(1,1);
partialDerivativesExcluded{1,1} = unconstrainedVariablesToExclude;
numOfPartialDerivativesExcluded = 0;

for iUnconstrainedVariablesToExclude = 1 : numOfUnconstrainedVariablesToExclude
    % Check if the excluded from jacobian calculation variable is also an unconstrained variable
    indexOfExcludedVariable = convertCharsToStrings(partialDerivatives) == convertCharsToStrings(unconstrainedVariablesToExclude{iUnconstrainedVariablesToExclude});
    
    if any( indexOfExcludedVariable )
        numOfPartialDerivativesExcluded                                 =   numOfPartialDerivativesExcluded + 1;
        % Update the partial derivatives variables that will be excluded
        partialDerivativesExcluded{numOfPartialDerivativesExcluded,1}	=   unconstrainedVariablesToExclude{iUnconstrainedVariablesToExclude};
        % Update the partial derivatives variables that will be included
        partialDerivatives                                              =   partialDerivatives(~indexOfExcludedVariable);
        
    end
    
end

%% Call gait function with front and back perturbation for each partial derivative
numOfPartialDerivatives = length(partialDerivatives);

for iPartialDerivative = 1 : numOfPartialDerivatives
        conditionsAfterFunctionCalls.(partialDerivatives{iPartialDerivative}).front  = gaitFunction(conditionsFunctionCalls.(partialDerivatives{iPartialDerivative}).front, simulationParameters);
        conditionsAfterFunctionCalls.(partialDerivatives{iPartialDerivative}).back   = gaitFunction(conditionsFunctionCalls.(partialDerivatives{iPartialDerivative}).back, simulationParameters);
            
end

%% Generate jacobian matrix
jacobianMatrix      = zeros(numOfPartialDerivatives, numOfPartialDerivatives);
jacobianSymbolic    = cell(numOfPartialDerivatives, numOfPartialDerivatives);

for iPartialDerivative = 1 : numOfPartialDerivatives
    stateStructureFront	= encodeStructure( conditionsAfterFunctionCalls.(partialDerivatives{iPartialDerivative}).front );
    stateStructureBack 	= encodeStructure( conditionsAfterFunctionCalls.(partialDerivatives{iPartialDerivative}).back );
    
    for jFunctionCall = 1 : numOfPartialDerivatives
        jacobianMatrix(jFunctionCall, iPartialDerivative)  = (  stateStructureFront.(partialDerivatives{jFunctionCall}) -...
                                                                stateStructureBack.(partialDerivatives{jFunctionCall}) ) / ...
                                                                perturbation;
        
        jacobianSymbolic{jFunctionCall, iPartialDerivative} = [partialDerivatives{jFunctionCall}, '/', partialDerivatives{iPartialDerivative}];
        
    end
end

% Assign calculated values to the Jacobian matrix structure
Jacobian.Matrix                         = jacobianMatrix;
Jacobian.Symbolic                       = jacobianSymbolic;
Jacobian.eigenValues                    = eig(jacobianMatrix);
Jacobian.eigenValuesNorm                = abs(eig(jacobianMatrix));
Jacobian.eigenValueMax                  = max(Jacobian.eigenValuesNorm);
Jacobian.partialDerivatives             = partialDerivatives;
Jacobian.partialDerivativesExcluded     = partialDerivativesExcluded;   

end
