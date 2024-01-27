function [xImpact, isImpactValid, lamdas4x1] = calculateImpactDSP21_SSP1(x, parameters, footshape)
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

M=parameters.M;
m1F=parameters.m1F;     m1T=parameters.m1T;     m2F=parameters.m2F;     m2T=parameters.m2T;

I=parameters.I;
I1F=parameters.I1F;     I1T=parameters.I1T;     I2F=parameters.I2F;     I2T=parameters.I2T;

L1F=parameters.L1F;     L1T=parameters.L1T;     L2F=parameters.L2F;     L2T=parameters.L2T;
l1F=parameters.l1F;     l1T=parameters.l1T;     l2F=parameters.l2F;     l2T=parameters.l2T;
l1Tx=parameters.l1Tx;   l2Tx=parameters.l2Tx;
l1=parameters.l1;       l2=parameters.l2;       l3=parameters.l3;   l4=parameters.l4;   l5=parameters.l5;   l6=parameters.l6;
ksiF=parameters.ksiF;   ksiT=parameters.ksiT;
alfa=parameters.alfa;   g=parameters.g;

%% Calculations
xImpact     = zeros(size(x));

% Positions are considered constant before and after the impact
xImpact(1:6) = x(1:6);

% Calculate the velocities
massMatrix      = mass6x6(x,parameters);
lamdaMatrix     = Lamda1_J(x,parameters,footshape);
impactMatrix    = [ massMatrix, -lamdaMatrix
                    lamdaMatrix', zeros( size(lamdaMatrix,2), size(lamdaMatrix,2) )];
impactResult    = impactMatrix^(-1)*[massMatrix*x(7:12); zeros(size(lamdaMatrix,2), 1)];
xImpact(7:12)   = impactResult(1:6);

% Check if the impact is valid
lamdas4x1 = GRF_DSP(xImpact,parameters,footshape);
if lamdas4x1(4) < 0
    isImpactValid = true;
else
    isImpactValid = false;
end

