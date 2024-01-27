function Gi = G6(alfa,ksiF,ksiT,l1,l2,l3,l4,l5,l2T,l2Tx,m2T,psiF,psiK)
%G6
%    Gi = G6(ALFA,ksiF,ksiT,L1,L2,L3,L4,L5,l2T,l2Tx,m2T,psiF,psiK)

%    This function was generated by the Symbolic Math Toolbox version 9.1.
%    16-Sep-2022 12:53:01

t2 = cos(psiK);
t3 = sin(psiK);
t4 = l1.^2;
t5 = l2.^2;
t6 = l3.^2;
t7 = l4.^2;
t10 = -l5;
t11 = 1.0./l1;
t8 = l3.*t2;
t9 = l4.*t2;
t12 = 1.0./t4;
t14 = -t4;
t15 = -t5;
t16 = l1+t10;
t20 = l4.*t3.*1i;
t13 = l4.*t8.*2.0;
t17 = -t8;
t18 = -t9;
t19 = -t13;
t21 = l4+t17;
t23 = l3+t18+t20;
t22 = t6+t7+t19;
t24 = angle(t23);
t25 = 1.0./t22;
t26 = 1.0./sqrt(t22);
t28 = ksiF+psiF+t24;
t31 = t5+t14+t22;
t32 = t4+t15+t22;
t27 = t26.^3;
t29 = cos(t28);
t30 = sin(t28);
t33 = t32.^2;
t34 = l4.*t21.*t25;
t35 = (t11.*t26.*t32)./2.0;
t36 = (t12.*t25.*t33)./4.0;
t38 = acos(t35);
t37 = -t36;
t41 = t28+t38;
t39 = t37+1.0;
t42 = ksiT+t41;
t40 = 1.0./sqrt(t39);
t43 = cos(t42);
t44 = sin(t42);
t45 = (l3.*l4.*t3.*t11.*t27.*t31.*t40)./2.0;
t46 = t34+t45;
Gi = m2T.*(cos(alfa).*(t16.*t46.*sin(t41)+l2T.*t44.*t46+l2Tx.*t43.*t46-l4.*t21.*t26.*t30-l3.*l4.*t3.*t26.*t29)+sin(alfa).*(t16.*t46.*cos(t41)+l2T.*t43.*t46-l2Tx.*t44.*t46-l4.*t21.*t26.*t29+l3.*l4.*t3.*t26.*t30));
