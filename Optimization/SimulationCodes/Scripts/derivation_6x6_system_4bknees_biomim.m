% Derivation of dynamic equations for a biped robot with 4 - bar knees
clc
clear

% Declaration of state variables & derivatives
syms xH yH thetaF thetaK psiF psiK  
syms xH_d yH_d thetaF_d thetaK_d psiF_d psiK_d 
syms xH_dd yH_dd thetaF_dd thetaK_dd psiF_dd psiK_dd 

assume([xH, yH, thetaF, thetaK, psiF, psiK ],'real');
assume([xH_d, yH_d, thetaF_d, thetaK_d, psiF_d, psiK_d ],'real');
assume([xH_dd, yH_dd, thetaF_dd, thetaK_dd, psiF_dd, psiK_dd],'real');

% Declaration of parameters
syms M m1F m1T m2F m2T
syms I I1F I1T I I2F I2T
syms L1F L1T L2F L2T l1F l2F l1T l2T
syms alfa alfaP k1 k2 g b1 b2
syms FKthK FKpsK
syms l1 l2 l3 l4 l1Tx l2Tx l5 l6
syms ksiF  ksiT 

assume([M, m1F, m1T, m2F, m2T],'real');
assume([I, I1F, I1T, I2F, I2T],'real');
assume([L1F, L1T, l1F, l1T, L2F, L2T, l2F, l2T],'real');
assume([alfa, alfaP, k1, b1 , k2 , b2, g], 'real');
assume([FKthK, FKpsK],'real');
assume([l1,l2,l3,l4,l5,l6],'positive')
assume([ksiF,ksiT],'real');

mass=[M, m1F, m1T, m2F, m2T];
inertia=[I, I1F, I1T, I2F, I2T];
q=[xH yH thetaF thetaK psiF psiK ];
qdot=[xH_d yH_d thetaF_d thetaK_d psiF_d psiK_d];
qdotdot=[xH_dd yH_dd thetaF_dd thetaK_dd psiF_dd psiK_dd ];
% 
% Mass coordinates -coord. system (xa,ya)
% Main mass M in point M --->xam(1),yam(1)
xam(1)=xH;
yam(1)=yH;
% Foot 1 upper mass m1U --->xam(2),yam(2)
xa1U=xH+l1F*sin(thetaF);
ya1U=yH-l1F*cos(thetaF);
xam(2)=xa1U;
yam(2)=ya1U;

%Femoral origin location
xFem = xH;
yFem = yH;

%Femoral origin velocity
xFem_d = diff(xFem,xH)*xH_d;
yFem_d = diff(yFem,yH)*yH_d;

str=strcat('Kinematics/xFem_calc.m');
matlabFunction(xFem,'file',str);

str=strcat('Kinematics/yFem_calc.m');
matlabFunction(yFem,'file',str);

str=strcat('Kinematics/xFem_d_calc.m');
matlabFunction(xFem_d,'file',str);

str=strcat('Kinematics/yFem_d_calc.m');
matlabFunction(yFem_d,'file',str);

% Knee configuration 1
A2A4=sqrt(l4^2+l3^2-2*l3*l4*cos(thetaK));
angle_temp_f=atan2(l4*sin(thetaK),(l3-l4*cos(thetaK)));
angle_temp_b=acos((l1^2+A2A4^2-l2^2)/2/l1/A2A4);
thetaT=thetaF+ksiF+angle_temp_f+angle_temp_b+ksiT;
str=strcat('Kinematics/thetaT_calc.m');
matlabFunction(thetaT,'file',str);
file1=fopen(str,'a');
fprintf( file1, '\nthetaT=wrapToPi(thetaT);');
fclose(file1);
thetaT_d =simplify(diff(thetaT,thetaF)*thetaF_d+diff(thetaT,thetaK)*thetaK_d);

str=strcat('Kinematics/thetaT_d_calc.m');
matlabFunction(thetaT_d,'file',str);

xU1=xH+L1F*sin(thetaF);
yU1=yH-L1F*cos(thetaF);
xA2=xU1+(l3-l6)*cos(thetaF+ksiF-pi/2);
yA2=yU1+(l3-l6)*sin(thetaF+ksiF-pi/2);
xA4=xA2+A2A4*cos(thetaF+pi/2+ksiF+angle_temp_f);
yA4=yA2+A2A4*sin(thetaF+pi/2+ksiF+angle_temp_f);
xB1=xA4+(l1-l5)*cos(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
yB1=yA4+(l1-l5)*sin(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);

% Tibial 1 origin location
xTib1 = xB1;
yTib1 = yB1;

xTib1_d = simplify(diff(xTib1,xH)*xH_d + diff(xTib1,yH)*yH_d + diff(xTib1,thetaF)*thetaF_d + diff(xTib1,thetaK)*thetaK_d);
yTib1_d = simplify(diff(yTib1,xH)*xH_d + diff(yTib1,yH)*yH_d + diff(yTib1,thetaF)*thetaF_d + diff(yTib1,thetaK)*thetaK_d);

str=strcat('Kinematics/xTib1_calc.m');
matlabFunction(xTib1,'file',str);

str=strcat('Kinematics/yTib1_calc.m');
matlabFunction(yTib1,'file',str);

str=strcat('Kinematics/xTib1_d_calc.m');
matlabFunction(xTib1_d,'file',str);

str=strcat('Kinematics/yTib1_d_calc.m');
matlabFunction(yTib1_d,'file',str);

% Foot 1 bottom mass m1B --->xam(3),yam(3)
xa1B=xB1+l1T*sin(thetaT)+l1Tx*cos(thetaT);
ya1B=yB1-l1T*cos(thetaT)+l1Tx*sin(thetaT);
xam(3)=xa1B;
yam(3)=ya1B;
% Foot 2 upper mass m2U --->xam(4),yam(4)
xa2U=xH+l2F*sin(psiF);
ya2U=yH-l2F*cos(psiF);
xam(4)=xa2U;
yam(4)=ya2U;

% Knee configuration 2
A2A4=sqrt(l4^2+l3^2-2*l3*l4*cos(psiK));
angle_temp_f=atan2(l4*sin(psiK),(l3-l4*cos(psiK)));
angle_temp_b=acos((l1^2+A2A4^2-l2^2)/2/l1/A2A4);
psiT=psiF+ksiF+angle_temp_f+angle_temp_b+ksiT;
str=strcat('Kinematics/psiT_calc.m');
matlabFunction(psiT,'file',str);
file1=fopen(str,'a');
fprintf( file1, '\npsiT=wrapToPi(psiT);');
fclose(file1);

psiT_d=simplify(diff(psiT,psiF)*psiF_d+diff(psiT,psiK)*psiK_d);

str=strcat('Kinematics/psiT_d_calc.m');
matlabFunction(psiT_d,'file',str);

xU2=xH+L2F*sin(psiF);
yU2=yH-L2F*cos(psiF);
xA2=xU2+(l3-l6)*cos(psiF+ksiF-pi/2);
yA2=yU2+(l3-l6)*sin(psiF+ksiF-pi/2);
xA4=xA2+A2A4*cos(psiF+pi/2+ksiF+angle_temp_f);
yA4=yA2+A2A4*sin(psiF+pi/2+ksiF+angle_temp_f);
xB2=xA4+(l1-l5)*cos(psiF+ksiF+angle_temp_f+angle_temp_b-pi/2);
yB2=yA4+(l1-l5)*sin(psiF+ksiF+angle_temp_f+angle_temp_b-pi/2);

% Tibial 2 origin location
xTib2 = xB2;
yTib2 = yB2;

xTib2_d = simplify(diff(xTib2,xH)*xH_d + diff(xTib2,yH)*yH_d + diff(xTib2,psiF)*psiF_d + diff(xTib2,psiK)*psiK_d);
yTib2_d = simplify(diff(yTib2,xH)*xH_d + diff(yTib2,yH)*yH_d + diff(yTib2,psiF)*psiF_d + diff(yTib2,psiK)*psiK_d);

str=strcat('Kinematics/xTib2_calc.m');
matlabFunction(xTib2,'file',str);

str=strcat('Kinematics/yTib2_calc.m');
matlabFunction(yTib2,'file',str);

str=strcat('Kinematics/xTib2_d_calc.m');
matlabFunction(xTib2_d,'file',str);

str=strcat('Kinematics/yTib2_d_calc.m');
matlabFunction(yTib2_d,'file',str);

% Foot 2 bottom mass m2B --->xam(5),yam(5)
xa2B=xB2+l2T*sin(psiT)+l2Tx*cos(psiT);
ya2B=yB2-l2T*cos(psiT)+l2Tx*sin(psiT);
xam(5)=xa2B;
yam(5)=ya2B;


% Ankle positions
c1x=xB1+L1T*sin(thetaT);
c1y=yB1-L1T*cos(thetaT);

str=strcat('Kinematics/c1x_calc.m');
matlabFunction(c1x,'file',str);
str=strcat('Kinematics/c1y_calc.m');
matlabFunction(c1y,'file',str);

c1xdi=0;
c1ydi=0;
for i=1:size(q,2)
    c1xdi=c1xdi+diff(c1x,q(i))*qdot(i);
    c1ydi=c1ydi+diff(c1y,q(i))*qdot(i);
end
c1x_d=c1xdi;
c1y_d=c1ydi;

str=strcat('Kinematics/c1x_d_calc.m');
matlabFunction(c1x_d,'file',str);
str=strcat('Kinematics/c1y_d_calc.m');
matlabFunction(c1y_d,'file',str);

c2x=xB2+L2T*sin(psiT);
c2y=yB2-L2T*cos(psiT);
str=strcat('Kinematics/c2x_calc.m');
matlabFunction(c2x,'file',str);
str=strcat('Kinematics/c2y_calc.m');
matlabFunction(c2y,'file',str);

% Mass heights - coord. system (x,y)
for j=1:size(mass,2)
    h(j)=xam(j)*sin(alfa)+yam(j)*cos(alfa);
end

% Linear Velocities
for j=1:size(mass,2)
    xam_dotj=0;
    yam_dotj=0;
    xamj=xam(j);
    yamj=yam(j);
    for i=1:size(q,2)
        qi=q(i);
        xam_dotj=xam_dotj+diff(xamj,qi)*qdot(i);
        yam_dotj=yam_dotj+diff(yamj,qi)*qdot(i);
    end
    xam_dot(j)=xam_dotj;
    yam_dot(j)=yam_dotj;
    um_sq(j)=xam_dot(j)^2+yam_dot(j)^2;
end

% Angular Velocities
w=[0,thetaF_d,thetaT_d,psiF_d,psiT_d];
w_sq=w.^2;

% Kinetic energy
K=0;
for j=1:size(mass,2)
   K=K+0.5*mass(j)*um_sq(j);
end
for j=1:size(inertia,2)
   K=K+0.5*inertia(j)*w_sq(j);
end


str=strcat('Misc/Kinetic_energy.m');
matlabFunction(K,'file',str);

% Potential energy
% from springs
% Uk=0.5*k1*(thetaU-thetaB)^2+0.5*k2*(psiU-psiB)^2;
% FK=[0,0,0,FKthK,0,FKpsK];%dthU/dthK=0

% from gravity
Ug=0;
for j=1:size(mass,2)
    Ug=Ug+mass(j)*g*h(j);
end
str=strcat('Misc\Potential_energy.m');
matlabFunction(Ug,'file',str);
% total potential energy
U=Ug;%Uk will be added in another form, externally

% Lagrangian
L=K-U;

% Calculate dL/dq terms
for i=1:size(q,2)
    dL_dq(i)=diff(L,q(i));
end

% Calculate dL/dqdot terms
for i=1:size(q,2)
    dL_dqdot(i)=diff(L,qdot(i));
end

% Calculate d(dL/dqdot)/dt terms
for i=1:size(q,2)
    ddj=0;
    dL_dqdoti=dL_dqdot(i);
    for j=1:size(q,2)
        qj=q(j);
        qdotj=qdot(j);
        ddj=ddj+diff(dL_dqdoti,qj)*qdot(j)+...
            diff(dL_dqdoti,qdotj)*qdotdot(j);
    end
    ddL_dqdot_dt(i)=ddj;
end

% % Energy dissipation rate
% Pc=0.5*b1*(thetaK_d)^2+0.5*b2*(psiK_d)^2;
% 
% % Calculate dPc/dqdot terms
% for i=1:size(q,2)
%     Fc(i)=diff(Pc,qdot(i));
% end

% Equations
for i=1:size(q,2)
    Eqleft(i)=(ddL_dqdot_dt(i)-dL_dq(i));
    fprintf('%s = 0 \n\n',char(Eqleft(i)));  
end

%
% Matrix form for accelerations
for i=1:1:size(q,2)
    single_support_B(i)=-Eqleft(i);
    for j=1:1:size(q,2)
        single_support_A(i,j)=diff(Eqleft(i),qdotdot(j));
        single_support_B(i)=(single_support_B(i)+single_support_A(i,j)*qdotdot(j));
        diff(single_support_B(i),qdotdot(j))
    end
    % Find the gravitational terms and the difference of the actual and the one we want mimic
  	single_support_GA(i)=g*diff(single_support_B(i),g);
    single_support_GP(i)=subs(single_support_GA(i),alfa,alfaP);
    single_support_Bg(i)=single_support_GA(i)-single_support_GP(i);
end

%%
for i=1:1:size(q,2)
    for j=1:1:size(q,2)
        Aij=single_support_A(i,j);
        str=strcat('Dynamics/Alfas/A',num2str(i),'',num2str(j),'.m');
        matlabFunction(Aij,'file',str);
        fprintf('matrixA(%i,%i) = %s; \n\n',i,j,(single_support_A(i,j)))
    end
end

for i=1:1:size(q,2)
    Bi=(single_support_B(i));
    str=strcat('Dynamics/Betas/B',num2str(i),'.m');
    matlabFunction(Bi,'file',str);
    fprintf('matrixB(%i) = %s; \n\n',i,single_support_B(i))
end

for i=1:1:size(q,2)
    Bgi=(single_support_Bg(i));
    str=strcat('Dynamics/BetasG/Bg',num2str(i),'.m');
    matlabFunction(Bgi,'file',str);
    fprintf('matrixBg(%i) = %s; \n\n',i,single_support_Bg(i))
end

%%
%
% Calculate dc/dq terms. Calculate constraint jacobian matrix. Based on algebraic contraint vector.
Constrs=[c1x,c1y,c2x,c2y];
for j=1:size(Constrs,2)
    for i=1:size(q,2)
        Lambda(i,j)=diff(Constrs(j),q(i));
        Lij=Lambda(i,j);
        str=strcat('Dynamics/Lamdas/L',num2str(i),'',num2str(j),'.m');
        matlabFunction(Lij,'file',str);
    end
end
for j=1:size(Lambda,1)
    for k=1:size(Lambda,2)
        Lambda_d_i=0;
        for i=1:size(q,2)
            Lambda_d_i=Lambda_d_i+diff(Lambda(j,k),q(i))*qdot(i);
        end
        Lambda_dot(j,k)=Lambda_d_i;
        Ldij=Lambda_dot(j,k);
        str=strcat('Dynamics/Lamda_dots/Ld',num2str(j),'',num2str(k),'.m');
        matlabFunction(Ldij,'file',str);
    end
end

%
DthT_DthF=diff(thetaT,thetaF);
DpsT_DpsF=diff(psiT,psiF);

str=strcat('Kinematics/DthT_DthF.m');
matlabFunction(DthT_DthF,'file',str);
str=strcat('Kinematics/DpsT_DpsF.m');
matlabFunction(DpsT_DpsF,'file',str);

DthT_DthK=diff(thetaT,thetaK);
DpsT_DpsK=diff(psiT,psiK);

str=strcat('Kinematics/DthT_DthK.m');
matlabFunction(DthT_DthK,'file',str);
str=strcat('Kinematics/DpsT_DpsK.m');
matlabFunction(DpsT_DpsK,'file',str);

DDthT_DDthK     =diff(DthT_DthK,thetaK);
DDpsT_DDpsK     =diff(DpsT_DpsK,psiK);

str=strcat('Kinematics/DDthT_DDthK.m');
matlabFunction(DDthT_DDthK,'file',str);
str=strcat('Kinematics/DDpsT_DDpsK.m');
matlabFunction(DDpsT_DDpsK,'file',str);

DDthT_DthKDthF  = diff(DthT_DthF,thetaK);
DDpsT_DpsKDpsF  = diff(DpsT_DpsF,psiK);

str=strcat('Kinematics/DDthT_DthKDthF.m');
matlabFunction(DDthT_DthKDthF,'file',str);
str=strcat('Kinematics/DDpsT_DpsKDpsF.m');
matlabFunction(DDpsT_DpsKDpsF,'file',str);

DDthT_DDthF=diff(DthT_DthF,thetaF);
DDpsT_DDpsF=diff(DpsT_DpsF,psiF);

str=strcat('Kinematics/DDthT_DDthF.m');
matlabFunction(DDthT_DDthF,'file',str);
str=strcat('Kinematics/DDpsT_DDpsF.m');
matlabFunction(DDpsT_DDpsF,'file',str);

DDthT_DthFDthK  = diff(DthT_DthK,thetaF);
DDpsT_DpsFDpsK  = diff(DpsT_DpsK,psiF);

str=strcat('Kinematics/DDthT_DthFDthK.m');
matlabFunction(DDthT_DthFDthK,'file',str);
str=strcat('Kinematics/DDpsT_DpsFDpsK.m');
matlabFunction(DDpsT_DpsFDpsK,'file',str);

for i=1:1:size(q,2)
    Gi=simplify(diff(single_support_B(i),g));
    str=strcat('Dynamics/Gs/G',num2str(i),'.m');
    matlabFunction(Gi,'file',str);
    fprintf('matrixG(%i) = %s; \n\n',i,Gi*g)
end

%% Genarate equation for poincare section constraint (Apex Height)

% Generate apex height constraint function
syms dyAnkle_d
assume(dyAnkle_d,'real');

yAnkleEquationAtMaxHeight = dyAnkle_d == c1y_d;    % Calculation of ankle's ydot based on the rule of chain
yH_d_Function  = solve(yAnkleEquationAtMaxHeight, yH_d);

str=strcat('Kinematics\yH_d_Function.m');
matlabFunction(yH_d_Function,'file',str);

% Generate apex height constraint derivative function
syms DdyAnkle_d_DthetaF
assume(DdyAnkle_d_DthetaF,'real');

DyH_d_Function_DthetaF  = diff(yH_d_Function, thetaF) + DdyAnkle_d_DthetaF;

str=strcat('Kinematics\DyH_d_Function_DthetaF.m');
matlabFunction(DyH_d_Function_DthetaF,'file',str);

%% Generate four bar mechanism equation

syms a b f g thFB psiFB thFB_d psiFB_d
assume([a b f g thFB psiFB thFB_d psiFB_d],'real');

% Definitions
k_1 = -2*a*b*sin(thFB);
k_2 = 2*b*(g-a*cos(thFB));
k_3 = g^2 + a^2 - f^2 + b^2 - 2*g*a*cos(thFB);

% Output angle psi
psiFB = 2*atan2(-k_1-sqrt(k_1.^2+k_2.^2-k_3.^2),k_3-k_2);
str=strcat('Kinematics\psiFB.m');
matlabFunction(psiFB,'file',str);

dpsiFB_dthFB = diff(psiFB, thFB);
str=strcat('Kinematics\dpsiFB_dthFB.m');
matlabFunction(dpsiFB_dthFB,'file',str);
