function stateConditions = encodeConditions(stateStructure)
%% encodeConditions 
% Description:  This functions takes as input a stateStructure struct and generates a stateConditions struct.
% 
% Inputs:       stateStructure:     struct that contains the each one of the reduced robot's state as a field.
%                                   For example stateStructure.ThetaF etc.
%
% Outputs:      stateConditions:  	struct that contains the reduced robot's state in the form of
%                                   1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                   2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com.

q                       = [stateStructure.thetaF,      stateStructure.thetaK,    stateStructure.psiF,      stateStructure.psiK];
qd                      = [stateStructure.thetaF_d,    stateStructure.thetaK_d,  stateStructure.psiF_d,    stateStructure.psiK_d];
stateConditions.q       = q;
stateConditions.qd      = qd;

end
