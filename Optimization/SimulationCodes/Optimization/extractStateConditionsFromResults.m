function stateConditions = extractStateConditionsFromResults(results)
%% extractStatePointConditionsFromResults 
% Description:  This function takes the last timestep data from the results struct and extracts the conditions
%               that correspond to it.               
% 
% Inputs:       results:            struct in which all the simulation run results are saved. 
%
% Outputs:      stateConditions:  	struct that contains the reduced robot's state in the form of
%                                   1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                   2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com.

%% Extract the State point in the form of initial conditions
% Calculate the state at the final simulation step.
decodedStructure.thetaF  	= results.thetaF(end);
decodedStructure.thetaK   	= results.thetaK(end);
decodedStructure.psiF   	= results.psiF(end);
decodedStructure.psiK     	= results.psiK(end);
decodedStructure.thetaF_d 	= results.thetaF_d(end);
decodedStructure.thetaK_d 	= results.thetaK_d(end);
decodedStructure.psiF_d   	= results.psiF_d(end);
decodedStructure.psiK_d   	= results.psiK_d(end);

stateConditions             = encodeConditions(decodedStructure);

end