function functionCalls = generateFunctionCallConditions(stateConditions, perturbation, simulationParameters, varargin)
%% generateFunctionCallConditions 
% Description:  generateFunctionCallConditions is a function that for each unconstrained variable the front and back perturbed condition are calculated.
%               The perturbed conditions are usefull for the retun map's jacobian matrix calculation 
%
% Inputs:       stateConditions:        struct that contains the reduced robot's state in the form of
%                                       1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                       2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%               
%               perturbation:           double value that is used as state variable's perturbation in the numerical calculation
%                                       of the biped retun map's jacobian matrix.
%               
%               simulationParameters:	struct that contains as fields
%                                       1) A struct with all the dimensional model pararameters. (Model) 
%                                       2) A struct with all the undimensional model parameters. (ModelFactors)
%                                       3) A struct that contains all the solver parameters. (Solver)
%                                       4) The section plane sturct. (sectionPlane)
%
% Outputs:
%
%               functionCalls:          struct that contains for each unconstrained variable the front and back perturbed conditions
%                                       needed for the retun map's jacobian matrix calculation. 
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Generate function calls base on the conditions
modelParameters                     = simulationParameters.Model;
sectionPlane                        = simulationParameters.sectionPlane;
variablesUnconstrained              = sectionPlane.VariablesUnconstrained;
numOfVariablesUnconstrained         = length(variablesUnconstrained);
stateStructure                      = encodeStructure(stateConditions);

for iVariableUnconstrained = 1 : numOfVariablesUnconstrained
    %%% Calculate conditions for front perturbation
    stateStructureFront                                                             = stateStructure;
    stateStructureFront.(variablesUnconstrained{iVariableUnconstrained})            = stateStructure.(variablesUnconstrained{iVariableUnconstrained}) + perturbation / 2;
    stateConditionsFront                                                            = encodeConditions(stateStructureFront);
    % Move state conditions up to the section plane
   	stateConditionsFront                                                            = sectionPlane.moveConditionsOnSectionPlane(stateConditionsFront, modelParameters);
    functionCalls.(variablesUnconstrained{iVariableUnconstrained}).front            = stateConditionsFront;
        
    %%% Calculate conditions for front perturbation
    stateStructureBack                                                              = stateStructure;
    stateStructureBack.(variablesUnconstrained{iVariableUnconstrained})             = stateStructure.(variablesUnconstrained{iVariableUnconstrained}) - perturbation / 2;
    stateConditionsBack                                                             = encodeConditions(stateStructureBack);
    % Move state conditions up to the section plane
   	stateConditionsBack                                                             = sectionPlane.moveConditionsOnSectionPlane(stateConditionsBack, modelParameters);
    functionCalls.(variablesUnconstrained{iVariableUnconstrained}).back             = stateConditionsBack;
    
end



end
