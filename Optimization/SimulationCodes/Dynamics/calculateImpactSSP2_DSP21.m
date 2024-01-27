function [xImpact, isImpactValid, lamdas4x1] = calculateImpactSSP2_DSP21(x,parametersModel)
%% calculateImpactSSP2_DSP21 
% Description:  This function takes the state of the model one timestep before the impact that leads in double stance phase.
%               The angular momentum conservation equations are applied taking into account the double stance phase constraints.
%               The reulting state vector corresponds to the step just after the impact with the ground.
% 
% Inputs:       x:                  double state vector that the DAE and solver reads. The state variables are assigned in the below sequence
%                                   1) The hips location at x direction. (x(1) = xH)
%                                   2) The hips location at y direction. (x(2) = yH)
%                                   3) The femoral angle of the foot 1 [rad]. (x(3) = thetaF)
%                                   4) The knee angle of the foot 1 [rad]. (x(4) = thetaK)
%                                   5) The femoral angle of the foot 2 [rad]. (x(5) = psiF)
%                                   6) The knee angle of the foot 2 [rad]. (x(6) = psiK)
%                                   7) The time derivative of hips location at x direction. (x(7) = xH_d)
%                                   8) The time derivative of hips location at y direction. (x(8) = yH_d)
%                                   9) The time derivative of femoral angle of the foot 1 [rad]. (x(9) = thetaF_d)
%                                   10) The time derivative of knee angle of the foot 1 [rad]. (x(10) = thetaK_d)
%                                   11) The time derivative of femoral angle of the foot 2 [rad]. (x(11) = psiF_d)
%                                   12) The time derivative of knee angle of the foot 2 [rad]. (x(12) = psiK_d)
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   In case that the robot is in single stance phase of the foot i (where i = 1 or 2)
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   13) The foot's i not slip constraint lagragian multiplier. (x(13) = lamda_ix)
%                                   14) The foot's i not ground perturbation constraint lagragian multiplier. (x(14) = lamda_iy)
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   In case that the robot is in double stance phase
%                                   -------------------------------------------------------------------------------------------------------------------------------------
%                                   13) The foot's 1 not slip constraint lagragian multiplier. (x(13) = lamda_1x)
%                                   14) The foot's 1 not ground perturbation constraint lagragian multiplier. (x(14) = lamda_1y)
%                                   15) The foot's 2 not slip constraint lagragian multiplier. (x(15) = lamda_2x)
%                                   16) The foot's 2 not ground perturbation constraint lagragian multiplier. (x(16) = lamda_2y)	
%
%               parametersModel: 	struct that contains all the dimensional parameters related to the robots model. As fields you can find.
%                                   1) The hip, femoral and tibial mass. (M, miF, miF. Where i corresponds to foot 1 -> i = 1 and foot 2 -> i = 2)
%                                   2) The femoral and tibial link lengths. (LiF, LiT. Where i corresponds to foot 1 -> i = 1 and foot 2 -> i = 2)
%                                   3) The femoral and tibial link's longitudinal center of mass (liF, liT. Where i corresponds to foot 1 -> i = 1 and foot 2 -> i = 2)
%                                   4) The femoral link's transverse center of mass (liTx. Where i corresponds to foot 1 -> i = 1 and foot 2 -> i = 2)
%                                 	5) The four bar link lengths. See four bar bar link section at 
%                                   explanations presentation (C:\Projects\BipedProject\Reports\Explanations.pptx). (l1, l2, l3, l4, l5, l6, ksiF, ksiT, knee_cap_angle) 
%                                   6) The rotational spring stiffness and damping at the knee cup. (k, b)
%                                   7) The fooshape and the foot's radius in case radial foot. (footshape, r0)
%                                   8) The slope angle of the ground in [rad]. (alfa)
%
%
% Outputs:      xImpact:            vector in the form of x state vector after the impact.
%                                   
%               isImpactValid:      flag that indicate if the impact actually leads the model in double stance phase.
%                                   The conditions for a valid double stance phase condition is that both feet no penetration ground reaction 
%                                   forces to be possitive. 
%
%             	lamdas4x1:          double vector that contains the ground reaction forces calculated in the double stance phase. Bellow you can find the sequence of them
%                                   1) Foot's 1 no slip reaction forece.                (lamdas4x1(1))
%                                   2) Foot's 1 no ground penetration reaction forece.  (lamdas4x1(2))
%                                   3) Foot's 2 no slip reaction forece.                (lamdas4x1(3))
%                                   4) Foot's 2 no ground penetration reaction forece.  (lamdas4x1(4))
%
% Author: Antonios Kantounias - Aikaterini Smyrli, Email: antonis.kantounias@gmail.com

%% Imputs
xH=x(1);
yH=x(2);
thetaF = x(3);
thetaK = x(4);
psiF = x(5);
psiK = x(6);

xH_d = x(7);
yH_d =x(8);
thetaF_d = x(9);
thetaK_d = x(10);
psiF_d = x(11);
psiK_d = x(12);

footshape = parametersModel.footshape;
M=parametersModel.M;
m1F=parametersModel.m1F;     m1T=parametersModel.m1T;     m2F=parametersModel.m2F;     m2T=parametersModel.m2T;

I=parametersModel.I;
I1F=parametersModel.I1F;     I1T=parametersModel.I1T;     I2F=parametersModel.I2F;     I2T=parametersModel.I2T;

L1F=parametersModel.L1F;     L1T=parametersModel.L1T;     L2F=parametersModel.L2F;     L2T=parametersModel.L2T;
l1F=parametersModel.l1F;     l1T=parametersModel.l1T;     l2F=parametersModel.l2F;     l2T=parametersModel.l2T;
l1Tx=parametersModel.l1Tx;   l2Tx=parametersModel.l2Tx;
l1=parametersModel.l1;       l2=parametersModel.l2;       l3=parametersModel.l3;   l4=parametersModel.l4;   l5=parametersModel.l5;   l6=parametersModel.l6;
ksiF=parametersModel.ksiF;   ksiT=parametersModel.ksiT;
alfa=parametersModel.alfa;   g=parametersModel.g;

%% Calculations
xImpact     = zeros(size(x));

% Positions are considered constant before and after the impact
xImpact(1:6) = x(1:6);

% Calculate after impact velocities
massMatrix      = mass6x6(x,parametersModel);
lamdaMatrix     = Lamda_J(x,parametersModel,footshape);
impactMatrix    = [ massMatrix, -lamdaMatrix
                    lamdaMatrix', zeros( size(lamdaMatrix,2), size(lamdaMatrix,2) )];
impactResult    = impactMatrix^(-1)*[massMatrix*x(7:12); zeros(size(lamdaMatrix,2), 1)];
xImpact(7:12)   = impactResult(1:6);

% Check if the impact is valid based on the ground reaction forces
lamdas4x1 = GRF_DSP(xImpact, parametersModel);
if lamdas4x1(4) > 0
    isImpactValid = true;
else
    isImpactValid = false;
end
