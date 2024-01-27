function [value,isterminal,direction] = HS_leg2(t,x,parametersModel)

% State vector
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

% Parameters
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

% Event description 
psiT = psiT_calc(ksiF,ksiT,l1,l2,l3,l4,psiF,psiK);
phi=interp1(footshape.psi,footshape.fi,psiT);
ri=interp1(footshape.psi,footshape.r,psiT);

height=c2y_calc(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF,psiK,yH);
touch=sin(-psiT-phi)*ri;
value=height-touch;

direction=0;
isterminal=1;

end
