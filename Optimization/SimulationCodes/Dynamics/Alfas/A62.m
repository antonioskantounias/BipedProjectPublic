function Aij = A62(ksiF,ksiT,l1,l2,l3,l4,l5,l2T,l2Tx,m2T,psiF,psiK)
%A62
%    AIJ = A62(KSIF,KSIT,L1,L2,L3,L4,L5,L2T,L2TX,M2T,PSIF,PSIK)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    27-Mar-2023 15:31:23

t2 = cos(psiK);
t3 = sin(psiK);
t4 = l1.^2;
t5 = l2.^2;
t6 = l3.^2;
t7 = l4.^2;
t10 = 1.0./l1;
t13 = pi./2.0;
t8 = t3.^2;
t9 = l4.*t2;
t11 = 1.0./t4;
t18 = t4./2.0;
t19 = t5./2.0;
t20 = t6./2.0;
t21 = t7./2.0;
t22 = l4.*t3.*1i;
t12 = l3.*t9;
t15 = -t9;
t23 = -t19;
t25 = t7.*t8;
t14 = t12.*2.0;
t16 = -t12;
t24 = l3+t15;
t17 = -t14;
t26 = t24.^2;
t27 = 1.0./t24;
t30 = t22+t24;
t43 = t16+t18+t20+t21+t23;
t28 = 1.0./t26;
t29 = t6+t7+t17;
t31 = t9.*t27;
t32 = angle(t30);
t34 = t15.*t27;
t38 = t25+t26;
t44 = t43.^2;
t33 = 1.0./t29;
t35 = t25.*t28;
t36 = 1.0./sqrt(t29);
t39 = 1.0./t38;
t40 = ksiF+psiF+t13+t32;
t37 = t36.^3;
t41 = l3.*l4.*t3.*t10.*t36;
t42 = t34+t35;
t45 = t11.*t33.*t44;
t46 = t10.*t36.*t43;
t52 = -t26.*t39.*(t31-t35);
t47 = acos(t46);
t48 = -t45;
t49 = l3.*l4.*t3.*t10.*t37.*t43;
t50 = t48+1.0;
t51 = -t49;
t54 = ksiF+ksiT+psiF+t32+t47;
t53 = 1.0./sqrt(t50);
t55 = t41+t51;
t56 = t53.*t55;
t57 = t52+t56;
Aij = m2T.*(l2Tx.*t57.*cos(t54).*2.0+l2T.*t57.*sin(t54).*2.0+t57.*cos(ksiF+psiF-t13+t32+t47).*(l1-l5).*2.0-l3.*l4.*t3.*t36.*sin(t40).*2.0-(t26.*t39.*cos(t40).*(t31-t35).*2.0)./t36).*(-1.0./2.0);
