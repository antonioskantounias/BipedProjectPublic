function Bg = betaG6x1(x,parameters)

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
alfa=parameters.alfa;   alfaP=parameters.alfaP;   g=parameters.g;

Bg(1,1) = Bg1(M,alfa,alfaP,g,m1F,m2F,m1T,m2T);
Bg(2,1) = Bg2(M,alfa,alfaP,g,m1F,m2F,m1T,m2T);
Bg(3,1) = Bg3(L1F,alfa,alfaP,g,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1F,l1T,l1Tx,m1F,m1T,thetaF,thetaK);
Bg(4,1) = Bg4(alfa,alfaP,g,ksiF,ksiT,l1,l2,l3,l4,l5,l1T,l1Tx,m1T,thetaF,thetaK);
Bg(5,1) = Bg5(L2F,alfa,alfaP,g,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l2F,l2T,l2Tx,m2F,m2T,psiF,psiK);
Bg(6,1) = Bg6(alfa,alfaP,g,ksiF,ksiT,l1,l2,l3,l4,l5,l2T,l2Tx,m2T,psiF,psiK);

end