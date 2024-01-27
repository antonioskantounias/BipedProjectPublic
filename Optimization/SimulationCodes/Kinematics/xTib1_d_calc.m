function xTib1_d = xTib1_d_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF,thetaK,thetaF_d,thetaK_d,xH_d)
%XTIB1_D_CALC
%    XTIB1_D = XTIB1_D_CALC(L1F,KSIF,L1,L2,L3,L4,L5,L6,THETAF,THETAK,THETAF_D,THETAK_D,XH_D)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    09-Sep-2023 20:11:02

t2 = cos(thetaK);
t3 = sin(thetaK);
t4 = l1.^2;
t5 = l2.^2;
t6 = l3.^2;
t7 = l4.^2;
t10 = -l5;
t11 = 1.0./l1;
t8 = l3.*t2;
t9 = l4.*t2;
t13 = -t5;
t14 = l1+t10;
t18 = l4.*t3.*1i;
t12 = l4.*t8.*2.0;
t15 = -t8;
t16 = -t9;
t17 = -t12;
t19 = l4+t15;
t21 = l3+t16+t18;
t20 = t6+t7+t17;
t22 = angle(t21);
t23 = 1.0./t20;
t24 = 1.0./sqrt(t20);
t25 = ksiF+t22+thetaF;
t27 = t4+t13+t20;
t26 = cos(t25);
t28 = (t11.*t24.*t27)./2.0;
t29 = acos(t28);
t30 = t25+t29;
t31 = cos(t30);
xTib1_d = xH_d-thetaK_d.*(t14.*t31.*(l4.*t19.*t23+(l3.*l4.*t3.*t11.*t24.^3.*1.0./sqrt((t23.*t27.^2.*(-1.0./4.0))./t4+1.0).*(-t4+t5+t20))./2.0)-l4.*t19.*t24.*t26+l3.*l4.*t3.*t24.*sin(t25))+thetaF_d.*(t14.*t31+L1F.*cos(thetaF)+cos(ksiF+thetaF).*(l3-l6)-t26./t24);
