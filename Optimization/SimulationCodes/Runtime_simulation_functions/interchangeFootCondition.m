function stateConditionsB = interchangeFootCondition(stateConditionsA)
%% interchangeFootCondition 
% Description:  This function interchanges the state variable condtion of the foot 1
%               with the conditions of the foot 2 and vise versa. 
% 
% Inputs:       stateConditions:	struct that contains the reduced robot's state in the form of
%                                   1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                   2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%
% Outputs:      stateConditions:	struct that contains the reduced robot's state in the form of
%                                   1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                   2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com.

%% Interchange the foot conditions
stateConditionsB.q(1)  = stateConditionsA.q(3);
stateConditionsB.q(2)  = stateConditionsA.q(4);
stateConditionsB.q(3)  = stateConditionsA.q(1);
stateConditionsB.q(4)  = stateConditionsA.q(2);

stateConditionsB.qd(1)  = stateConditionsA.qd(3);
stateConditionsB.qd(2)  = stateConditionsA.qd(4);
stateConditionsB.qd(3)  = stateConditionsA.qd(1);
stateConditionsB.qd(4)  = stateConditionsA.qd(2);

end