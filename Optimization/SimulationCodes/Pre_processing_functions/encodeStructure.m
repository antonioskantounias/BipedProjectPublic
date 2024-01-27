function [stateStructure] = encodeStructure(stateConditions) 
%% encodeStructure 
% Description: This function takes as input structure a stateConditions struct and generates a stateStructure struct.
%
% Inputs:      stateConditions:  	struct that contains the reduced robot's state in the form of
%                                   1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                   2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%
% Outputs:       stateStructure:    struct that contains the each one of the reduced robot's state as a field.
%                                 	For example stateStructure.ThetaF etc.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

stateStructure.thetaF       = stateConditions.q(1);
stateStructure.thetaK     = stateConditions.q(2);
stateStructure.psiF       = stateConditions.q(3);
stateStructure.psiK       = stateConditions.q(4);

stateStructure.thetaF_d 	= stateConditions.qd(1);
stateStructure.thetaK_d 	= stateConditions.qd(2);
stateStructure.psiF_d   	= stateConditions.qd(3);
stateStructure.psiK_d    	= stateConditions.qd(4);

end
