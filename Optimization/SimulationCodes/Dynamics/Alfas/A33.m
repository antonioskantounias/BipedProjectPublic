function Aij = A33(I1F,I1T,L1F,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1F,l1T,l1Tx,m1F,m1T,thetaF,thetaK)
%A33
%    AIJ = A33(I1F,I1T,L1F,KSIF,KSIT,L1,L2,L3,L4,L5,L6,L1F,L1T,L1TX,M1F,M1T,THETAF,THETAK)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    27-Mar-2023 15:31:20

t2 = cos(thetaF);
t3 = cos(thetaK);
t4 = sin(thetaF);
t5 = sin(thetaK);
t6 = l1.^2;
t7 = l2.^2;
t8 = l3.^2;
t9 = l4.^2;
t10 = l1F.^2;
t12 = -l5;
t13 = -l6;
t14 = 1.0./l1;
t16 = pi./2.0;
t11 = l4.*t3;
t18 = l1+t12;
t19 = l3+t13;
t21 = -t16;
t24 = t6./2.0;
t25 = t7./2.0;
t26 = t8./2.0;
t27 = t9./2.0;
t28 = l4.*t5.*1i;
t15 = l3.*t11;
t20 = -t11;
t29 = -t25;
t30 = ksiF+t21+thetaF;
t17 = t15.*2.0;
t22 = -t15;
t32 = l3+t20+t28;
t23 = -t17;
t33 = angle(t32);
t37 = t22+t24+t26+t27+t29;
t31 = t8+t9+t23;
t36 = ksiF+t16+t33+thetaF;
t34 = sqrt(t31);
t35 = 1.0./t34;
t38 = t14.*t35.*t37;
t39 = acos(t38);
t40 = ksiF+ksiT+t33+t39+thetaF;
t43 = t30+t33+t39;
t41 = cos(t40);
t42 = sin(t40);
Aij = I1F+I1T+(m1F.*(t2.^2.*t10.*2.0+t4.^2.*t10.*2.0))./2.0+(m1T.*((L1F.*t4+l1T.*t42+l1Tx.*t41+t19.*cos(t30)+t18.*cos(t43)+t34.*cos(t36)).^2.*2.0+(-L1F.*t2-l1T.*t41+l1Tx.*t42+t19.*sin(t30)+t18.*sin(t43)+t34.*sin(t36)).^2.*2.0))./2.0;
