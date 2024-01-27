%% Four-bar linkage
% Animation of a four-bar linkage.
%
% Reference: 
%
% Tang, C.P., 2010. Lagrangian dynamic formulation of a four-bar mechanism
% with minimal coordinates.
%
%% 
clear ; close all ; clc
%% Parameters
% Bars

% Case T1>0, T2>0, T3>0
% a=0.8;b=0.8;f=0.8;g=1;

% Case T1<0, T2>0, T3<0
% a=0.8;b=1;f=1;g=1;

% Case T1>0, T2<0, T3>0
% a=1;b=0.8;f=1;g=1;

% Case T1>0, T2<0, T3<0
% a=1;b=1;f=1.2;g=1;

% Case T1<0, T2>0, T3>0
% a=1;b=1;f=0.8;g=1;

% Case T1<0, T2>0, T3<0
% a=1;b=1.2;f=1;g=1;

% Case T1<0, T2<0, T3>0
% a=1.2;b=1;f=1;g=1;

% Case T1<0, T2<0, T3<0
a=1.2;b=1.2;f=1.2;g=1;

% Video
numOfInstances = 10; % Time                          [s]

% Four bar mechanism
[FourBarMech] = calculate4BarMechanism(a,b,g,f);

% Input anlge theta
th_vet = linspace(FourBarMech.ThetaMin+0.1*pi/180,FourBarMech.ThetaMax-0.1*pi/180,numOfInstances);

psi_vet = zeros(1, numOfInstances);
for i = 1 : numOfInstances
    
    psi_vet(i) = psiFB(a,b,f,g,th_vet(i));

end

% Gear ratio
dpsi_vet_dth_vet = dpsiFB_dthFB(a,b,f,g,th_vet);

% Alpha angle

alpha_vet = atan2(-a*sin(th_vet)+b*sin(psi_vet),g-a*cos(th_vet)+b*cos(psi_vet));

% Mechanism's pin joints loacations
point_A_x_cum = a*cos(th_vet); % Point A cummulative
point_A_y_cum = a*sin(th_vet); % Point A cummulative
point_B_x_cum = g+b*cos(psi_vet); % Point B cummulative
point_B_y_cum = b*sin(psi_vet); % Point B cummulative

%% Plot
psi_vetDeg = psi_vet*180/pi;
th_vetDeg  = th_vet*180/pi;
% figure
% plot(th_vetDeg,1./dpsi_vet_dth_vet)
% figure
% plot(th_vetDeg,psi_vetDeg)
% figure
% plot(psi_vetDeg,dpsi_vet_dth_vet)


%% Animation
color = cool(5); % Colormap
figure
% set(gcf,'Position',[50 50 1280 720])  % YouTube: 720p
% set(gcf,'Position',[50 50 854 480])   % YouTube: 480p
set(gcf,'Position',[50 50 640 640])     % Social
hold on ; grid on ; box on ; axis equal
set(gca,'FontName','Verdana','FontSize',18)
title('Four-bar linkage')
% Create and open video writer object
for i=1:numOfInstances
    cla
    % Angles
    th      = th_vet(i);
    phi     = psi_vet(i);
    alpha   = alpha_vet(i);
    % Bar 1
    bar_1_x = [0 a*cos(th)];
    bar_1_y = [0 a*sin(th)];
    
    % Bar 2
    bar_2_x = [a*cos(th) a*cos(th)+f*cos(alpha)];
    bar_2_y = [a*sin(th) a*sin(th)+f*sin(alpha)];
    % Bar 3
    bar_3_x = [g g+b*cos(phi)];
    bar_3_y = [0 b*sin(phi)];
    
    % Trajectory
    % Point A
    plot(point_A_x_cum(1:i),point_A_y_cum(1:i),'Color',color(1,:),'LineWidth',3) % Point A trajectory
    % Point B
    plot(point_B_x_cum(1:i),point_B_y_cum(1:i),'Color',color(5,:),'LineWidth',3) % Point B trajectory
    
    % Fixed bar
    plot([bar_1_x(1) bar_3_x(1)],[0 0],'k','LineWidth',7)           % Bar 0
    
    % Bars attached to fixed bar
    plot(bar_1_x,bar_1_y,'Color',color(2,:),'LineWidth',7)          % Bar 1
    plot(bar_3_x,bar_3_y,'Color',color(4,:),'LineWidth',7)          % Bar 3
    
    % Bearings
    plot(bar_1_x(1),bar_1_y(1),'k^','MarkerFaceColor','k','MarkerSize',15) % Point O
    plot(bar_3_x(1),bar_3_y(1),'k^','MarkerFaceColor','k','MarkerSize',15) % Point O'
    
    % Bar 2
    plot(bar_2_x,bar_2_y,'Color',color(3,:),'LineWidth',7) % Bar 2
    
    % Points 
    plot(bar_2_x(1),bar_2_y(1),'ko','MarkerFaceColor',color(1,:),'MarkerSize',10)      % Point A
    plot(bar_3_x(end),bar_3_y(end),'ko','MarkerFaceColor',color(5,:),'MarkerSize',10)  % Point B
    
    %Setting axes limits
    x_range = [point_A_x_cum ;  point_B_x_cum];
    y_range = [point_A_y_cum ;  point_B_y_cum];
    
    set(gca,'xlim',[-2,2],'ylim',[-2,2])
    set(gca,'xtick',[],'ytick',[])
        
end
