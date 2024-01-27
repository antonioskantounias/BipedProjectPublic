function [Ldot] = Lamda_dot_J(x,parameters,footshape)

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

thetaT=thetaT_calc(ksiF,ksiT,l1,l2,l3,l4,thetaF,thetaK);
psiT=psiT_calc(ksiF,ksiT,l1,l2,l3,l4,psiF,psiK);

thetaT_d = thetaT_d_calc(l1,l2,l3,l4,thetaK,thetaF_d,thetaK_d);
psiT_d = psiT_d_calc(l1,l2,l3,l4,psiK,psiF_d,psiK_d);

if and( wrapToPi(-thetaT)>=min(footshape.theta) ,wrapToPi(-thetaT) <= max(footshape.theta) )
    dxc1_dth=interp1(footshape.theta,footshape.dc1x_dth,wrapToPi(-thetaT),'pchip');
    dyc1_dth=interp1(footshape.theta,footshape.dc1y_dth,wrapToPi(-thetaT),'pchip');
    ddxc1_ddth=interp1(footshape.theta,footshape.ddxc1_ddth,wrapToPi(-thetaT),'pchip');
    ddyc1_ddth=interp1(footshape.theta,footshape.ddyc1_ddth,wrapToPi(-thetaT),'pchip');
elseif wrapToPi(-thetaT)<min(footshape.theta)
    dxc1_dth=footshape.dc1x_dth(1);
    dyc1_dth=footshape.dc1y_dth(1);
    ddxc1_ddth=footshape.ddxc1_ddth(1);
    ddyc1_ddth=footshape.ddyc1_ddth(1);
else
    dxc1_dth=footshape.dc1x_dth(end);
    dyc1_dth=footshape.dc1y_dth(end);
    ddxc1_ddth=footshape.ddxc1_ddth(end);
    ddyc1_ddth=footshape.ddyc1_ddth(end);
end

if and( wrapToPi(-psiT)>=min(footshape.theta) ,wrapToPi(-psiT)<= max(footshape.theta) )
    dxc2_dps=interp1(footshape.theta,footshape.dc1x_dth,wrapToPi(-psiT),'pchip');
    dyc2_dps=interp1(footshape.theta,footshape.dc1y_dth,wrapToPi(-psiT),'pchip');
    ddxc2_ddps=interp1(footshape.theta,footshape.ddxc1_ddth,wrapToPi(-psiT),'pchip');
    ddyc2_ddps=interp1(footshape.theta,footshape.ddyc1_ddth,wrapToPi(-psiT),'pchip');
elseif wrapToPi(-psiT)<min(footshape.theta)
    dxc2_dps=footshape.dc1x_dth(1);
    dyc2_dps=footshape.dc1y_dth(1);
    ddxc2_ddps=footshape.ddxc1_ddth(1);
    ddyc2_ddps=footshape.ddyc1_ddth(1);
else
    dxc2_dps=footshape.dc1x_dth(end);
    dyc2_dps=footshape.dc1y_dth(end);
    ddxc2_ddps=footshape.ddxc1_ddth(end);
    ddyc2_ddps=footshape.ddyc1_ddth(end);
end


dthT_dthK=DthT_DthK(l1,l2,l3,l4,thetaK);
dpsT_dpsK=DpsT_DpsK(l1,l2,l3,l4,psiK);
ddthT_ddthK=DDthT_DDthK(l1,l2,l3,l4,thetaK);
ddpsT_ddpsK=DDpsT_DDpsK(l1,l2,l3,l4,psiK);

dthT_dthF = DthT_DthF();
ddthT_ddthF = DDthT_DDthF();
dpsT_dpsF = DpsT_DpsF();
ddpsT_ddpsF = DDpsT_DDpsF();

Ldot(1,1)=Ld11;
Ldot(1,2)=Ld12;
Ldot(1,3)=Ld13;
Ldot(1,4)=Ld14;

Ldot(2,1)=Ld21;
Ldot(2,2)=Ld22;
Ldot(2,3)=Ld23;
Ldot(2,4)=Ld24;

Ldot(3,1)=Ld31(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF,thetaK,thetaF_d,thetaK_d)-thetaT_d*(ddxc1_ddth*dthT_dthF)-dxc1_dth*ddthT_ddthF*thetaF_d;
Ldot(3,2)=Ld32(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF,thetaK,thetaF_d,thetaK_d)-thetaT_d*(ddyc1_ddth*dthT_dthF)-dyc1_dth*ddthT_ddthF*thetaF_d;
Ldot(3,3)=Ld33;
Ldot(3,4)=Ld34;

Ldot(4,1)=Ld41(L1T,ksiF,ksiT,l1,l2,l3,l4,l5,thetaF,thetaK,thetaF_d,thetaK_d)-thetaT_d*(ddxc1_ddth*dthT_dthK)-dxc1_dth*ddthT_ddthK*thetaK_d;
Ldot(4,2)=Ld42(L1T,ksiF,ksiT,l1,l2,l3,l4,l5,thetaF,thetaK,thetaF_d,thetaK_d)-thetaT_d*(ddyc1_ddth*dthT_dthK)-dyc1_dth*ddthT_ddthK*thetaK_d;
Ldot(4,3)=Ld43;
Ldot(4,4)=Ld44;

Ldot(5,1)=Ld51;
Ldot(5,2)=Ld52;
Ldot(5,3)=Ld53(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF,psiK,psiF_d,psiK_d)-psiT_d*(ddxc2_ddps*dpsT_dpsF)-dxc2_dps*ddpsT_ddpsF*psiF_d;
Ldot(5,4)=Ld54(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF,psiK,psiF_d,psiK_d)-psiT_d*(ddyc2_ddps*dpsT_dpsF)-dyc2_dps*ddpsT_ddpsF*psiF_d;

Ldot(6,1)=Ld61;
Ldot(6,2)=Ld62;
Ldot(6,3)=Ld63(L2T,ksiF,ksiT,l1,l2,l3,l4,l5,psiF,psiK,psiF_d,psiK_d)-psiT_d*(ddxc2_ddps*dpsT_dpsK)-dxc2_dps*ddpsT_ddpsK*psiK_d;
Ldot(6,4)=Ld64(L2T,ksiF,ksiT,l1,l2,l3,l4,l5,psiF,psiK,psiF_d,psiK_d)-psiT_d*(ddyc2_ddps*dpsT_dpsK)-dyc2_dps*ddpsT_ddpsK*psiK_d;


end