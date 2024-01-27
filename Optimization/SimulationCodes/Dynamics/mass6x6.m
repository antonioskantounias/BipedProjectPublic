function A = mass6x6(x,parameters)

%The main mass matrix of the 6x6 system

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

A(1,1) = A11(M,m1F,m2F,m1T,m2T);
A(1,2) = A12;
A(1,3) = A13(L1F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1F,l1T,l1Tx,m1F,m1T,thetaF,thetaK);
A(1,4) = A14(ksiF,ksiT,l1,l2,l3,l4,l5,l1T,l1Tx,m1T,thetaF,thetaK);
A(1,5) = A15(L2F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l2F,l2T,l2Tx,m2F,m2T,psiF,psiK);
A(1,6) = A16(ksiF,ksiT,l1,l2,l3,l4,l5,l2T,l2Tx,m2T,psiF,psiK);

A(2,1) = A(1,2);
A(2,2) = A22(M,m1F,m2F,m1T,m2T);
A(2,3) = A23(L1F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1F,l1T,l1Tx,m1F,m1T,thetaF,thetaK);
A(2,4) = A24(ksiF,ksiT,l1,l2,l3,l4,l5,l1T,l1Tx,m1T,thetaF,thetaK);
A(2,5) = A25(L2F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l2F,l2T,l2Tx,m2F,m2T,psiF,psiK);
A(2,6) = A26(ksiF,ksiT,l1,l2,l3,l4,l5,l2T,l2Tx,m2T,psiF,psiK);

A(3,1) = A(1,3);
A(3,2) = A(2,3);
A(3,3) = A33(I1F,I1T,L1F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1F,l1T,l1Tx,m1F,m1T,thetaF,thetaK);
A(3,4) = A34(I1T,L1F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1T,l1Tx,m1T,thetaF,thetaK);
A(3,5) = A35;
A(3,6) = A36;

A(4,1) = A(1,4);
A(4,2) = A(2,4);
A(4,3) = A(3,4);
A(4,4) = A44(I1T,ksiF,ksiT,l1,l2,l3,l4,l5,l1T,l1Tx,m1T,thetaF,thetaK);
A(4,5) = A45;
A(4,6) = A46;

A(5,1) = A(1,5);
A(5,2) = A(2,5);
A(5,3) = A(3,5);
A(5,4) = A(4,5);
A(5,5) = A55(I2F,I2T,L2F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l2F,l2T,l2Tx,m2F,m2T,psiF,psiK);
A(5,6) = A56(I2T,L2F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l2T,l2Tx,m2T,psiF,psiK);

A(6,1) = A(1,6);
A(6,2) = A(2,6);
A(6,3) = A(3,6);
A(6,4) = A(4,6);
A(6,5) = A(5,6);
A(6,6) = A66(I2T,ksiF,ksiT,l1,l2,l3,l4,l5,l2T,l2Tx,m2T,psiF,psiK);



end



