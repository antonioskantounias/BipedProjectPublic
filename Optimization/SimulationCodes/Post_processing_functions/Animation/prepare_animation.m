function figIDAnimation =  prepare_animation(parameters)
    figIDAnimation = figure;
    
    %Plot parameters
    xmax=3;
    xmin=-xmax;
    ymin=xmax*tan(parameters.alfa)-1;
    ymax=(parameters.L1F+parameters.L1T)*cos(parameters.alfa)+1;
    
    ax_annot = axes('Position',[0.13 0 0.775 0.6],'Visible','off');
    axis_plot= axes('Position',[0.13 0.3 0.775 0.6]);
    % axis(axis_plot);

%     subplot(2,1,1)
    %Plot background
    x1_axis=line([-xmax,xmax],[-xmax*tan(parameters.alfa),xmax*tan(parameters.alfa)],'Color',[0.7,0.7,0.7]) ;
    y1_axis=line([0,-xmax*tan(parameters.alfa)],[0,ymax],'Color',[0.7,0.7,0.7]);
    %y_axis=line([0,0],[ymin,ymax],'Color','k')
    %x_axis=line([xmin,xmax],[0,0],'Color','k')
    %axis manual
    axis equal
    %axis([xmin,xmax,ymin,ymax]);
    grid on
    hold on
%     subplot(2,1,1)
    xlabel('x [m]')
    ylabel('y [m]')

    
%     subplot(2,1,2)
%     angles1=[50:0.01:100];
%     U=(angles1<=parameters.knee_cap_angle)*1/2*parameters.KP.*((angles1-parameters.knee_cap_angle)/180*pi).^2;
%     plot(angles1,U,'k')
%     xlim([min(angles1),max(angles1)])
%     hold on
%     xlabel('knee angle [deg]')
%     ylabel('kneecap spring force [N]')
% 
%     plot_misc.U=U;
%     plot_misc.angles1=angles1;
end