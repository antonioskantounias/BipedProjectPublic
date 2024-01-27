clc
clear 
close all

thetaF=0/180*pi;
xH=0;
yH=1;
L1F=1;
L1T=L1F;

l1=0.0305*0.6;
l2=0.0322*0.6;
l3=0.0128*0.6;
l4=0.0299*0.6;
l5=l1/2;
l6=l3/2;

ksiF=(90-65)/180*pi;
ksiT=(90-14.73)/180*pi;

thetas=[0 10 20 30]/180*pi;
fig1= figure(1);
fig1.Position=[680 830 560 148];
xlab=["(a)","(b)","(c)","(d)"];
col=[0.4941    0.1843    0.5569];
xc=[];
yc=[];
for    thetaK=[0:1:60]/180*pi;
    %
    % Knee configuration 1
    A2A4=sqrt(l4^2+l3^2-2*l3*l4*cos(thetaK));
    angle_temp_f=atan2(l4*sin(thetaK),(l3-l4*cos(thetaK)));
    angle_temp_b=acos((l1^2+A2A4^2-l2^2)/2/l1/A2A4);
    thetaT=thetaF+ksiF+angle_temp_f+angle_temp_b+ksiT;
    % ksiT=thetaT-thetaF-ksiF-angle_temp_f-angle_temp_b;
    
    xU=xH+L1F*sin(thetaF);
    yU=yH-L1F*cos(thetaF);
    xA2=xU+(l3-l6)*cos(thetaF+ksiF-pi/2);
    yA2=yU+(l3-l6)*sin(thetaF+ksiF-pi/2);
    xA4=xA2+A2A4*cos(thetaF+pi/2+ksiF+angle_temp_f);
    yA4=yA2+A2A4*sin(thetaF+pi/2+ksiF+angle_temp_f);
    xB=xA4+(l1-l5)*cos(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    yB=yA4+(l1-l5)*sin(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    %
    
    xA1=xA4+l1*cos(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    yA1=yA4+l1*sin(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    
    xA3=xU-l6*cos(thetaF+ksiF-pi/2);
    yA3=yU-l6*sin(thetaF+ksiF-pi/2);
    
    xB2=xB+L1T*sin(thetaT);
    yB2=yB-L1T*cos(thetaT);

    a1=(yA2-yA1)/(xA2-xA1);
    b1=yA2-a1*xA2;

    a2=(yA3-yA4)/(xA3-xA4);
    b2=yA3-a2*xA3;

    x_CENTER=((b2-b1)/(a1-a2));
    y_CENTER=(a1*x_CENTER+b1);

    xc=[xc,x_CENTER];
    yc=[yc,y_CENTER];
    end
for i=1:1:4

    
    thetaK=thetas(i);
    %
    % Knee configuration 1
    A2A4=sqrt(l4^2+l3^2-2*l3*l4*cos(thetaK));
    angle_temp_f=atan2(l4*sin(thetaK),(l3-l4*cos(thetaK)));
    angle_temp_b=acos((l1^2+A2A4^2-l2^2)/2/l1/A2A4);
    thetaT=thetaF+ksiF+angle_temp_f+angle_temp_b+ksiT;
    % ksiT=thetaT-thetaF-ksiF-angle_temp_f-angle_temp_b;
    
    xU=xH+L1F*sin(thetaF);
    yU=yH-L1F*cos(thetaF);
    xA2=xU+(l3-l6)*cos(thetaF+ksiF-pi/2);
    yA2=yU+(l3-l6)*sin(thetaF+ksiF-pi/2);
    xA4=xA2+A2A4*cos(thetaF+pi/2+ksiF+angle_temp_f);
    yA4=yA2+A2A4*sin(thetaF+pi/2+ksiF+angle_temp_f);
    xB=xA4+(l1-l5)*cos(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    yB=yA4+(l1-l5)*sin(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    %
    
    xA1=xA4+l1*cos(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    yA1=yA4+l1*sin(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    
    xA3=xU-l6*cos(thetaF+ksiF-pi/2);
    yA3=yU-l6*sin(thetaF+ksiF-pi/2);
    
    xB2=xB+L1T*sin(thetaT);
    yB2=yB-L1T*cos(thetaT);

    a1=(yA2-yA1)/(xA2-xA1);
    b1=yA2-a1*xA2;

    a2=(yA3-yA4)/(xA3-xA4);
    b2=yA3-a2*xA3;

    x_CENTER=((b2-b1)/(a1-a2));
    y_CENTER=(a1*x_CENTER+b1);
    
    subplot(1,4,i)
    plot([xH xU]*1000,[yH yU]*1000,'LineWidth',2,'Color','k')
    hold on
    axis equal
    plot([xA3 xA2]*1000,[yA3 yA2]*1000,'LineWidth',2,'Color','k')
    plot([xA1 xA2]*1000,[yA1 yA2]*1000,'LineWidth',2,'Color','k')
    plot([xA3 xA4]*1000,[yA3 yA4]*1000,'LineWidth',2,'Color','k')
    plot([xA1 xA4]*1000,[yA1 yA4]*1000,'LineWidth',2,'Color','k')
    plot([xB xB2]*1000,[yB yB2]*1000,'LineWidth',2,'Color','k')
    plot([xA3 xA2]*1000,[yA3 yA2]*1000,'LineWidth',1.5,'Color',col)
    plot([xA1 xA2]*1000,[yA1 yA2]*1000,'LineWidth',1.5,'Color',col)
    plot([xA3 xA4]*1000,[yA3 yA4]*1000,'LineWidth',1.5,'Color',col)
    plot([xA1 xA4]*1000,[yA1 yA4]*1000,'LineWidth',1.5,'Color',col)
    %plot(xU*1000,yU*1000,'ro')
    %plot(xB*1000,yB*1000,'ro')
    plot(xA1*1000,yA1*1000,'ko','MarkerFaceColor','w','MarkerSize',6)
    plot(xA1*1000,yA1*1000,'ko','MarkerFaceColor','k','MarkerSize',2)
    plot(xA2*1000,yA2*1000,'ko','MarkerFaceColor','w','MarkerSize',6)
    plot(xA2*1000,yA2*1000,'ko','MarkerFaceColor','k','MarkerSize',2)
    plot(xA3*1000,yA3*1000,'ko','MarkerFaceColor','w','MarkerSize',6)
    plot(xA3*1000,yA3*1000,'ko','MarkerFaceColor','k','MarkerSize',2)
    plot(xA4*1000,yA4*1000,'ko','MarkerFaceColor','w','MarkerSize',6)
    plot(xA4*1000,yA4*1000,'ko','MarkerFaceColor','k','MarkerSize',2)

    if i==4
        
        plot(xc*1000,yc*1000,'m')
    
    end
    c1x=c1x_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF,thetaK,xH);
    c1y = c1y_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF,thetaK,yH);
    plot(c1x*1000,c1y*1000,'gs')
    ylim([-20 10])
    xlim([-20 10])
    set(gca,'YTickLabel', [])
    set(gca,'XTickLabel', [])
    title(['\phi=',num2str(round(thetaK*180/pi)),char(176),', \theta_t=',num2str(round(wrapToPi(thetaT)*180/pi)),char(176)]);
    xlabel(xlab(i))
end
yU-yA2;
yA2-yB;
%%
i=0;
for thetaK=[-5:0.00001:10]/180*pi
    i=i+1;
    thetaK_i(i)=thetaK;
    A2A4=sqrt(l4^2+l3^2-2*l3*l4*cos(thetaK));
    angle_temp_f=atan2(l4*sin(thetaK),(l3-l4*cos(thetaK)));
    angle_temp_b=acos((l1^2+A2A4^2-l2^2)/2/l1/A2A4);
    thetaT=thetaF+ksiF+angle_temp_f+angle_temp_b+ksiT;
    thetaT_i(i)=thetaT;


    xU=xH+L1F*sin(thetaF);
    yU=yH-L1F*cos(thetaF);
    xA2=xU+(l3-l6)*cos(thetaF+ksiF-pi/2);
    yA2=yU+(l3-l6)*sin(thetaF+ksiF-pi/2);
    xA4=xA2+A2A4*cos(thetaF+pi/2+ksiF+angle_temp_f);
    yA4=yA2+A2A4*sin(thetaF+pi/2+ksiF+angle_temp_f);
    xB=xA4+(l1-l5)*cos(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    yB=yA4+(l1-l5)*sin(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    %
    
    xA1=xA4+l1*cos(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    yA1=yA4+l1*sin(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
    
    xA3=xU-l6*cos(thetaF+ksiF-pi/2);
    yA3=yU-l6*sin(thetaF+ksiF-pi/2);
    
    xB2=xB+L1T*sin(thetaT);
    yB2=yB-L1T*cos(thetaT);

    slope_a3a2=(yA3-yA2)/(xA3-xA2);
    slope_a1a2=(yA1-yA2)/(xA1-xA2);
    
    angle_f1(i)=atan((slope_a3a2-slope_a1a2)/(1+slope_a3a2*slope_a1a2));
end

figure
diffs=diff(thetaK_i)./diff(thetaT_i);
plot_thetaK=thetaK_i(1:end-1)+(thetaK_i(2:end)-thetaK_i(1:end-1))/2;
plot(plot_thetaK*180/pi,diffs);
compare_ratios.thetaK=plot_thetaK;
compare_ratios.diff=diffs;
xlabel('\theta_K')
ylabel('d\theta_K/d\theta_T')

figure
diffs2=diff(angle_f1)./diff(thetaT_i);
plot_f=angle_f1(1:end-1)+(angle_f1(2:end)-angle_f1(1:end-1))/2;
plot(plot_thetaK*180/pi,diffs2);