function [graphs4] = post_processing(parameters,results)
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


psiF=results.psiF;
psiT=results.psiT;
thetaF=results.thetaF;
thetaT=results.thetaT;
psiF_d=results.psiF_d;
psiT_d=results.psiT_d;
thetaF_d=results.thetaF_d;
thetaT_d=results.thetaT_d;
psiK_d=results.psiK_d;
psiK=results.psiK;
thetaK_d=results.thetaK_d;
thetaK=results.thetaK;
xH_d=results.xH_d;
yH_d=results.yH_d;
xH=results.xH;
yH=results.yH;
%%

%Kinetic energy
K=Kinetic_energy(I1F,I2F,I1T,I2T,L1F,L2F,M,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1F,l2F,l1T,l2T,l1Tx,l2Tx,m1F,m2F,m1T,m2T,psiF,psiK,psiF_d,psiK_d,thetaF,thetaK,thetaF_d,thetaK_d,xH_d,yH_d);
%plot(results.t,K)

%Potential energy
Ug = Potential_energy(L1F,L2F,M,alfa,g,ksiF,ksiT,l1,l2,l3,l4,l5,l6,l1F,l2F,l1T,l2T,l1Tx,l2Tx,m1F,m2F,m1T,m2T,psiF,psiK,thetaF,thetaK,xH,yH);

%Elastic energy + damped
knees_cap_theta=thetaK<=parameters.knee_cap_angle;
knees_cap_psi=psiK<=parameters.knee_cap_angle;
Elastic=parameters.k*(thetaK.^2.*knees_cap_theta+psiK.^2.*knees_cap_psi)/2;
Damping=cumtrapz(results.t,parameters.b*results.thetaK_d.^2.*knees_cap_theta+parameters.b*results.psiK_d.^2.*knees_cap_psi);
% figure
% plot(results.t,K+Ug+Elastic+Damping)

total=K+Ug+Elastic+Damping;

%Sum of damped energy
j=0;
Damping_tot(1)=0;
for i=1:length(results.thetaK)-1
    if results.phase(i+1)~=results.phase(i)
        j=j+1;%step number
        GRF_loss(j)=total(i)-total(i+1);
%         Damping_tot(i+1)=Damping(i+1)+GRF_loss(j);
    end
    if j==10
        jj=i+1;%index of 10th step number start
    end
    if j>0
        Damping_tot(i+1)=Damping(i+1)+sum(GRF_loss(1:j));
    else
        Damping_tot(i+1)=Damping(i+1);
    end
end
% energetic metrics
i_mid=jj;
watt_b=parameters.b*results.thetaK_d.^2.*knees_cap_theta+parameters.b*results.psiK_d.^2.*knees_cap_psi;
mean_watt_b=trapz(results.t(i_mid:end),watt_b(i_mid:end))/(results.t(end)-results.t(i_mid));
avg_GRF_loss=sum(GRF_loss(11:end))/(j-10);
Damping_10=Damping_tot(jj:end);
Damping_10=Damping_10-Damping_10(1);
Elastic_10=Elastic(jj:end);
t_10=results.t(jj:end);

% Outputs
graphs4.avg_velocity=trapz(results.t(i_mid:end),results.xH_d(i_mid:end))/(results.t(end)-results.t(i_mid));
graphs4.max_force=max(results.lamda4((i_mid:end)));
graphs4.mean_watt_b=mean_watt_b;
graphs4.tot_dist=max(results.xH)-min(results.xH);
graphs4.thetaT=results.thetaT;
graphs4.thetaT_d=results.thetaT_d;
graphs4.thetaF=results.thetaF;
graphs4.thetaF_d=results.thetaF_d;
graphs4.foot_cl=0.002258;
graphs4.t=results.t;
graphs4.thetaK=results.thetaK;
graphs4.thetaK_d=results.thetaK_d;
graphs4.psi=results.psiK;
graphs4.psiK_d=results.psiK_d;
graphs4.xH_d=results.xH_d;
graphs4.yH_d=results.yH_d;
graphs4.Kinetic_energy=K;
graphs4.avg_GRF_loss=avg_GRF_loss;
motor_power=parameters.k*(thetaK.*results.thetaK_d.*knees_cap_theta+psiK.*results.psiK_d.*knees_cap_psi)+parameters.b*results.thetaK_d.^2.*knees_cap_theta+parameters.b*results.psiK_d.^2.*knees_cap_psi;
graphs4.spring_power=parameters.k*(thetaK.*results.thetaK_d.*knees_cap_theta+psiK.*results.psiK_d.*knees_cap_psi);
graphs4.damper_power=parameters.b*results.thetaK_d.^2.*knees_cap_theta+parameters.b*results.psiK_d.^2.*knees_cap_psi;
graphs4.motor_work=trapz(results.t(jj:end),motor_power(jj:end))/10;
graphs4.elastic_energy=Elastic_10;
graphs4.damped_energy=Damping_10;
graphs4.t10=t_10;
graphs4.jj=jj;

end