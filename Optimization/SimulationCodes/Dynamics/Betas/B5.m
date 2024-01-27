function Bi = B5(I2T,L2F,alfa,g,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l2F,l2T,l2Tx,m2F,m2T,psiF,psiK,psiF_d,psiK_d,xH_d,yH_d)
%B5
%    BI = B5(I2T,L2F,ALFA,G,KSIF,KSIT,L1,L2,L3,L4,L5,L6,L2F,L2T,L2TX,M2F,M2T,PSIF,PSIK,PSIF_D,PSIK_D,XH_D,YH_D)

%    This function was generated by the Symbolic Math Toolbox version 8.6.
%    27-Mar-2023 15:31:35

t2 = cos(alfa);
t3 = cos(psiF);
t4 = cos(psiK);
t5 = sin(alfa);
t6 = sin(psiF);
t7 = sin(psiK);
t8 = l1.^2;
t9 = l2.^2;
t10 = l3.^2;
t11 = l4.^2;
t12 = l4.^3;
t18 = -l5;
t19 = -l6;
t20 = 1.0./l1;
t25 = pi./2.0;
t13 = t7.^2;
t14 = t7.^3;
t15 = L2F.*t3;
t16 = L2F.*t6;
t17 = l4.*t4;
t21 = 1.0./t8;
t23 = l2F.*psiF_d.*t3;
t24 = l2F.*psiF_d.*t6;
t27 = -t8;
t28 = -t9;
t30 = l1+t18;
t31 = l3+t19;
t33 = -t25;
t36 = t8./2.0;
t37 = t9./2.0;
t38 = t10./2.0;
t39 = t11./2.0;
t40 = l4.*t7.*1i;
t46 = t4.*t7.*t11.*2.0;
t22 = l3.*t17;
t29 = -t15;
t32 = -t17;
t41 = t23+xH_d;
t42 = t24+yH_d;
t43 = -t37;
t45 = t11.*t13;
t47 = ksiF+psiF+t33;
t26 = t22.*2.0;
t34 = -t22;
t44 = l3+t32;
t48 = cos(t47);
t49 = sin(t47);
t35 = -t26;
t50 = t44.^2;
t52 = 1.0./t44;
t55 = l4.*t7.*t44.*2.0;
t57 = t40+t44;
t61 = t31.*t48;
t62 = t31.*t49;
t89 = t34+t36+t38+t39+t43;
t51 = t50.^2;
t53 = 1.0./t50;
t54 = t52.^3;
t56 = t10+t11+t35;
t58 = t17.*t52;
t59 = l4.*t7.*t52;
t60 = angle(t57);
t65 = t32.*t52;
t71 = t45+t50;
t77 = t46+t55;
t91 = t89.^2;
t63 = 1.0./t56;
t66 = sqrt(t56);
t67 = t45.*t53;
t72 = t12.*t14.*t54.*2.0;
t73 = t4.*t7.*t11.*t53.*3.0;
t75 = 1.0./t71;
t78 = t9+t27+t56;
t79 = t8+t28+t56;
t80 = ksiF+psiF+t25+t60;
t64 = t63.^2;
t68 = 1.0./t66;
t74 = -t72;
t76 = t75.^2;
t81 = t79.^2;
t82 = cos(t80);
t83 = sin(t80);
t88 = t65+t67;
t90 = (t58-t67).^2;
t102 = t21.*t63.*t91;
t106 = l3.*l4.*t7.*t21.*t63.*t89.*2.0;
t114 = -t50.*t75.*(t58-t67);
t117 = l4.*t7.*t44.*t75.*(t58-t67).*-2.0;
t69 = t68.^3;
t70 = t68.^5;
t84 = t20.*t22.*t68;
t85 = l3.*l4.*t7.*t20.*t68;
t92 = t66.*t82;
t93 = t66.*t83;
t94 = l3.*l4.*t7.*t68.*t82;
t95 = l3.*l4.*t7.*t68.*t83;
t96 = (t21.*t63.*t81)./4.0;
t100 = t59+t73+t74;
t103 = t20.*t68.*t89;
t105 = -t102;
t110 = l3.*l4.*t7.*t21.*t64.*t91.*2.0;
t131 = -t50.*t76.*t77.*(t58-t67);
t132 = t50.*t76.*t77.*(t58-t67);
t86 = t10.*t20.*t45.*t69.*2.0;
t97 = -t95;
t98 = -t96;
t104 = acos(t103);
t107 = t20.*t22.*t69.*t89;
t108 = l3.*l4.*t7.*t20.*t69.*t89;
t109 = t105+1.0;
t111 = t20.*t34.*t69.*t89;
t113 = -t110;
t118 = t10.*t20.*t45.*t70.*t89.*3.0;
t130 = t50.*t75.*t100;
t136 = t92.*t114;
t137 = t93.*t114;
t87 = -t86;
t99 = t98+1.0;
t112 = -t108;
t115 = 1.0./sqrt(t109);
t119 = ksiF+ksiT+psiF+t60+t104;
t127 = t47+t60+t104;
t138 = t106+t113;
t101 = 1.0./sqrt(t99);
t116 = t115.^3;
t120 = cos(t119);
t121 = sin(t119);
t128 = cos(t127);
t129 = sin(t127);
t135 = t85+t112;
t140 = t84+t87+t111+t118;
t122 = l2T.*t120;
t123 = l2Tx.*t120;
t124 = l2T.*t121;
t125 = l2Tx.*t121;
t133 = t30.*t128;
t134 = t30.*t129;
t139 = t115.*t135;
t143 = t115.*t140;
t144 = (t116.*t135.*t138)./2.0;
t126 = -t122;
t141 = t114+t139;
t150 = t16+t61+t92+t123+t124+t133;
t157 = t117+t130+t132+t143+t144;
t142 = t141.^2;
t145 = t124.*t141;
t146 = t125.*t141;
t147 = t122.*t141;
t148 = t123.*t141;
t149 = t126.*t141;
t151 = psiF_d.*t150;
t152 = t133.*t141;
t153 = t134.*t141;
t154 = t29+t62+t93+t125+t126+t134;
t155 = psiF_d.*t154;
t158 = t97+t136+t145+t148+t152;
t159 = t94+t137+t146+t149+t153;
t156 = -t155;
t160 = psiK_d.*t158;
t161 = psiK_d.*t159;
t162 = -t160;
t163 = -t161;
t167 = t156+t161+xH_d;
t164 = t151+t162;
t166 = t155+t163;
t165 = t164+yH_d;
Bi = psiF_d.*((m2T.*(t150.*t166.*2.0+t150.*t167.*2.0-t154.*t164.*2.0+t154.*t165.*2.0))./2.0-(m2F.*(l2F.*t3.*t42.*2.0-l2F.*t6.*t41.*2.0))./2.0)+(m2F.*(t23.*t42.*2.0-t24.*t41.*2.0))./2.0-(m2T.*(t164.*t167.*2.0+t165.*t166.*2.0))./2.0-psiK_d.*((m2T.*(t159.*t165.*2.0+t158.*t167.*2.0-t150.*(psiK_d.*(t92.*t117+t92.*t130+t92.*t132+t125.*t142+t126.*t142+t134.*t142+t123.*t157+t124.*t157+t133.*t157+t34.*t68.*t83+t10.*t45.*t69.*t83+t51.*t76.*t90.*t93-t50.*t75.*t94.*(t58-t67).*2.0)-psiF_d.*t159).*2.0-t154.*(psiF_d.*t158-psiK_d.*(-t93.*t130+t93.*t131+t123.*t142+t124.*t142+t133.*t142+t122.*t157-t125.*t157-t134.*t157+t34.*t68.*t82+t10.*t45.*t69.*t82+t51.*t76.*t90.*t92+t50.*t75.*t95.*(t58-t67).*2.0+t55.*t75.*t93.*(t58-t67))).*2.0))./2.0-I2T.*psiK_d.*(l3.*l4.*t7.*t63-l3.*t7.*t11.*t64.*(l4-l3.*t4).*2.0+t10.*t20.*t45.*t69.*t101+(t20.*t22.*t69.*t78.*t101)./2.0-t10.*t20.*t45.*t70.*t78.*t101.*(3.0./2.0)+(l3.*l4.*t7.*t20.*t69.*t78.*t101.^3.*(l3.*l4.*t7.*t21.*t63.*t79-(l3.*l4.*t7.*t21.*t64.*t81)./2.0))./4.0))-g.*m2T.*(t2.*t150-t5.*t154)-g.*m2F.*(l2F.*t2.*t6+l2F.*t3.*t5);
