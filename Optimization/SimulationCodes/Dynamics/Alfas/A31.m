function Aij = A31(L1F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1F,l1T,l1Tx,m1F,m1T,thetaF,thetaK)
%A31
%    AIJ = A31(L1F,KSIF,KSIT,L1,L2,L3,L4,L5,L6,L1F,L1T,L1TX,M1F,M1T,THETAF,THETAK)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    27-Mar-2023 15:31:19

t2 = cos(thetaF);
t3 = cos(thetaK);
t4 = sin(thetaK);
t5 = l1.^2;
t6 = l2.^2;
t7 = l3.^2;
t8 = l4.^2;
t10 = 1.0./l1;
t12 = pi./2.0;
t9 = l4.*t3;
t15 = -t12;
t18 = t5./2.0;
t19 = t6./2.0;
t20 = t7./2.0;
t21 = t8./2.0;
t22 = l4.*t4.*1i;
t11 = l3.*t9;
t14 = -t9;
t23 = -t19;
t13 = t11.*2.0;
t16 = -t11;
t25 = l3+t14+t22;
t17 = -t13;
t26 = angle(t25);
t28 = t16+t18+t20+t21+t23;
t24 = t7+t8+t17;
t27 = 1.0./sqrt(t24);
t29 = t10.*t27.*t28;
t30 = acos(t29);
t31 = ksiF+ksiT+t26+t30+thetaF;
Aij = m1T.*(sin(ksiF+t15+t26+t30+thetaF).*(l1-l5).*2.0+sin(ksiF+t15+thetaF).*(l3-l6).*2.0-L1F.*t2.*2.0-l1T.*cos(t31).*2.0+l1Tx.*sin(t31).*2.0+(sin(ksiF+t12+t26+thetaF).*2.0)./t27).*(-1.0./2.0)+l1F.*m1F.*t2;
