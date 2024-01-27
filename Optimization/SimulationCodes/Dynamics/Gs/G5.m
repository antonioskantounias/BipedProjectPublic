function Gi = G5(L2F,alfa,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l2F,l2T,l2Tx,m2F,m2T,psiF,psiK)
%G5
%    Gi = G5(L2F,ALFA,ksiF,ksiT,L1,L2,L3,L4,L5,L6,l2F,l2T,l2Tx,m2F,m2T,psiF,psiK)

%    This function was generated by the Symbolic Math Toolbox version 9.1.
%    16-Sep-2022 12:50:00

t2 = cos(psiK);
t3 = sin(psiK);
t4 = ksiF+psiF;
t5 = l1.^2;
t6 = l2.^2;
t7 = l3.^2;
t8 = l4.^2;
t10 = -l5;
t11 = -l6;
t12 = 1.0./l1;
t9 = l4.*t2;
t14 = -t6;
t15 = l1+t10;
t16 = l3+t11;
t19 = l4.*t3.*1i;
t13 = l3.*t9.*2.0;
t17 = -t9;
t18 = -t13;
t21 = l3+t17+t19;
t20 = t7+t8+t18;
t22 = angle(t21);
t23 = sqrt(t20);
t25 = t4+t22;
t26 = t5+t14+t20;
t24 = 1.0./t23;
t27 = (t12.*t24.*t26)./2.0;
t28 = acos(t27);
t29 = t25+t28;
t30 = ksiT+t29;
t31 = cos(t30);
t32 = sin(t30);
Gi = -m2T.*(sin(alfa).*(l2T.*t31-l2Tx.*t32+L2F.*cos(psiF)+t16.*cos(t4)+t15.*cos(t29)-t23.*cos(t25))+cos(alfa).*(l2T.*t32+l2Tx.*t31+L2F.*sin(psiF)+t16.*sin(t4)+t15.*sin(t29)-t23.*sin(t25)))-l2F.*m2F.*sin(alfa+psiF);
