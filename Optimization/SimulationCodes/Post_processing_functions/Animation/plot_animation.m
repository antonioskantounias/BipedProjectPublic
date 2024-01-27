function mov = plot_animation(figIDAnimation,parameters,footshape,results,plot_misc)
    
    figure(figIDAnimation.Number)
    L1F=parameters.L1F;     L1T=parameters.L1T;     L2F=parameters.L2F;     L2T=parameters.L2T;
    l1F=parameters.l1F;     l1T=parameters.l1T;     l2F=parameters.l2F;     l2T=parameters.l2T;
    
    l1Tx=parameters.l1Tx;   l2Tx=parameters.l2Tx;
    l1=parameters.l1;       l2=parameters.l2; l3=parameters.l3;         l4=parameters.l4;l5=parameters.l5;         l6=parameters.l6;
    ksiF=parameters.ksiF;   ksiT=parameters.ksiT;
    alfa=parameters.alfa;   g=parameters.g;
    
    xM_plot=[];
    yM_plot=[];
    ii=0;
    
    
%     [footClearanceXLocation,footClearance]=rotate_coord(results.footClearanceXLocation, results.footClearance, alfa);
%     plot(footClearanceXLocation, footClearance)
    
    clear mov
    %Plot frame by frame
    for ti=0:plot_misc.plot_step:max(results.t)
        [mindt,i]=min(abs(results.t-ti));
        
        ii=ii+1;
    %    Preallocate movie structure.
    %     mov(ii) = struct('cdata', [],'colormap', []);
%         subplot(2,1,1)
        phase_i=results.phase(i);
        xH_i=results.xH(i);
        yH_i=results.yH(i);
        thetaF_i=results.thetaF(i);
        thetaK_i=results.thetaK(i);
        psiF_i=results.psiF(i);
        psiK_i=results.psiK(i);
        thetaT_i = results.thetaT(i);
        psiT_i = results.psiT(i);
        
    %    coordinates in Xa Ya system
        cx1_i=c1x_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF_i,thetaK_i,xH_i);
        cy1_i=c1y_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF_i,thetaK_i,yH_i);
     %   Center of foot 2  
        cx2_i=c2x_calc(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF_i,psiK_i,xH_i);
        cy2_i=c2y_calc(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF_i,psiK_i,yH_i);
        %Mass M
        xaM=xH_i;
        yaM=yH_i;
        xM_plot=[xM_plot; xaM];
        yM_plot=[yM_plot; yaM];    
        %Mass m1U
        xam1U=xH_i+l1F*sin(thetaF_i);
        yam1U=yH_i-l1F*cos(thetaF_i);
        %Mass m1B
        xam1B=cx1_i-(L1T-l1T)*sin(thetaT_i)+l1Tx*cos(thetaT_i);
        yam1B=cy1_i+(L1T-l1T)*cos(thetaT_i)+l1Tx*sin(thetaT_i);
        %Mass m2U
        xam2U=xH_i+l2F*sin(psiF_i);
        yam2U=yH_i-l2F*cos(psiF_i);
        %Mass m2B
        xam2B=cx2_i-(L2T-l2T)*sin(psiT_i)+l2Tx*cos(psiT_i);
        yam2B=cy2_i+(L2T-l2T)*cos(psiT_i)+l2Tx*sin(psiT_i);
        
        %Knee 1
        xak1=xH_i+L1F*sin(thetaF_i);
        yak1=yH_i-L1F*cos(thetaF_i);
        xakb1=cx1_i-L1T*sin(thetaT_i);
        yakb1=cy1_i+L1T*cos(thetaT_i);
        [xaA1_1,yaA1_1,xaA2_1,yaA2_1,xaA3_1,yaA3_1,xaA4_1,yaA4_1] = knee_config(ksiF,L1F,l1,l2,l3,l4,l5,l6,thetaK_i,thetaF_i,xH_i,yH_i);   
        %Knee 2
        xak2=xH_i+L2F*sin(psiF_i);
        yak2=yH_i-L2F*cos(psiF_i);
        xakb2=cx2_i-L2T*sin(psiT_i);
        yakb2=cy2_i+L2T*cos(psiT_i);
        [xaA1_2,yaA1_2,xaA2_2,yaA2_2,xaA3_2,yaA3_2,xaA4_2,yaA4_2] = knee_config(ksiF,L1F,l1,l2,l3,l4,l5,l6,psiK_i,psiF_i,xH_i,yH_i);
    %    % Base of spring/damping mechanism 1
    %     xab1=cx1_i-r0*sin(theta_i);
    %     yab1=cy1_i-r0*cos(theta_i);
    %    % Base of rocker/spring mechanism 2
    %     xab2=xaM+L2_i*sin(psi_i);
    %     yab2=yaM-L2_i*cos(psi_i);
    
       % Coordinates in X Y system
    %    Center of rocker 1
        [xc1,yc1]=rotate_coord(cx1_i,cy1_i,alfa);
        %Center of rocker 2
        [xc2,yc2]=rotate_coord(cx2_i,cy2_i,alfa);
        %Mass M
        [xM,yM]=rotate_coord(xaM,yaM,alfa);
        %Mass m1U
        [xm1U,ym1U]=rotate_coord(xam1U,yam1U,alfa);
        %Mass m1B
        [xm1B,ym1B]=rotate_coord(xam1B,yam1B,alfa);
        %Mass m2U
        [xm2U,ym2U]=rotate_coord(xam2U,yam2U,alfa);
        %Mass m2B
        [xm2B,ym2B]=rotate_coord(xam2B,yam2B,alfa);
        %Knee 1
        [xk1,yk1]=rotate_coord(xak1,yak1,alfa);
        [xkb1,ykb1]=rotate_coord(xakb1,yakb1,alfa);   
        [xA1_1,yA1_1]=rotate_coord(xaA1_1,yaA1_1,alfa);
        [xA2_1,yA2_1]=rotate_coord(xaA2_1,yaA2_1,alfa);
        [xA3_1,yA3_1]=rotate_coord(xaA3_1,yaA3_1,alfa);
        [xA4_1,yA4_1]=rotate_coord(xaA4_1,yaA4_1,alfa);
        %Knee 2
        [xk2,yk2]=rotate_coord(xak2,yak2,alfa);
        [xkb2,ykb2]=rotate_coord(xakb2,yakb2,alfa);
        [xA1_2,yA1_2]=rotate_coord(xaA1_2,yaA1_2,alfa);
        [xA2_2,yA2_2]=rotate_coord(xaA2_2,yaA2_2,alfa);
        [xA3_2,yA3_2]=rotate_coord(xaA3_2,yaA3_2,alfa);
        [xA4_2,yA4_2]=rotate_coord(xaA4_2,yaA4_2,alfa);
        
      %  Rocker circle
        x_el=footshape.x;
        y_el=footshape.y;
        [el_rot1x,el_rot1y]=rotate_coord(x_el,y_el,thetaT_i+alfa);
        xel_1=el_rot1x+xc1;
        yel_1=el_rot1y+yc1;
        rocker1=plot(xel_1,yel_1,'Color',[0 153 153]/255,'LineWidth',2);
        
        [el_rot2x,el_rot2y]=rotate_coord(x_el,y_el,psiT_i+alfa);
        xel_2=el_rot2x+xc2;
        yel_2=el_rot2y+yc2;
        rocker2=plot(xel_2,yel_2,'Color',[153 0 153]/255,'LineWidth',2);
    
         %   Trajectory
        comet=plot(xM,yM,'Color',[102 102 255]/255,'Marker','.','MarkerSize',15);
        
        %Line L1
        line_L1F=line([xk1,xM],[yk1,yM],'Color',[0 102 102]/255,'LineWidth',2);
        line_L1T=line([xkb1,xc1],[ykb1,yc1],'Color',[0 153 153]/255,'LineWidth',2);
        %Line L2
        line_L2F=line([xk2,xM],[yk2,yM],'Color',[76 0 153]/255,'LineWidth',2);
        line_L2T=line([xkb2,xc2],[ykb2,yc2],'Color',[153 0 153]/255,'LineWidth',2);
       % Mass M
        massM_obj=plot(xM,yM,'o','LineWidth',0.5,'MarkerFaceColor',[0 0 102]/255,'MarkerEdgeColor','w','MarkerSize',8);
        %Mass m1U
        massm1F_obj=viscircles([xm1U,ym1U],0.01,'Color',[0 102 102]/255);
        %Mass m1B
        massm1T_obj=viscircles([xm1B,ym1B],0.01,'Color',[0 153 153]/255);
        %Mass m2U
        massm2F_obj=viscircles([xm2U,ym2U],0.01,'Color',[76 0 153]/255);
        %Mass m2B
        massm2T_obj=viscircles([xm2B,ym2B],0.01,'Color',[153 0 153]/255);
    %    Lever
        %lever=line([xp,xm],[yp,ym],'Color','y');
        
        line_f11=line([xel_1(1),xc1],[yel_1(1),yc1],'Color',[0 153 153]/255,'LineWidth',2);
        line_f21=line([xel_1(end),xc1],[yel_1(end),yc1],'Color',[0 153 153]/255,'LineWidth',2);
        line_f12=line([xel_2(1),xc2],[yel_2(1),yc2],'Color',[153 0 153]/255,'LineWidth',2);
        line_f22=line([xel_2(end),xc2],[yel_2(end),yc2],'Color',[153 0 153]/255,'LineWidth',2);
        
        %knee joints
        bar1_1=line([xA1_1,xA2_1],[yA1_1,yA2_1],'Color',[0 130 130]/255,'LineWidth',2);
        bar2_1=line([xA3_1,xA2_1],[yA3_1,yA2_1],'Color',[0 102 102]/255,'LineWidth',2);
        bar3_1=line([xA3_1,xA4_1],[yA3_1,yA4_1],'Color',[0 130 130]/255,'LineWidth',2);
        bar4_1=line([xA1_1,xA4_1],[yA1_1,yA4_1],'Color',[0 153 153]/255,'LineWidth',2);
        
        bar1_2=line([xA1_2,xA2_2],[yA1_2,yA2_2],'Color',[110 0 153]/255,'LineWidth',2);
        bar2_2=line([xA3_2,xA2_2],[yA3_2,yA2_2],'Color',[76 0 153]/255,'LineWidth',2);
        bar3_2=line([xA3_2,xA4_2],[yA3_2,yA4_2],'Color',[110 0 153]/255,'LineWidth',2);
        bar4_2=line([xA1_2,xA4_2],[yA1_2,yA4_2],'Color',[153 0 153]/255,'LineWidth',2);
        
        jk1=plot(xA3_1,yA3_1,'o','MarkerFaceColor','k','MarkerEdgeColor','w','MarkerSize',2);
        jk2=plot(xA3_2,yA3_2,'o','MarkerFaceColor','k','MarkerEdgeColor','w','MarkerSize',2);
    
       


        if results.phase(i)==1
            fx=results.lamda1(i);
            fy=results.lamda2(i);
            [fx,fy]=rotate_coord(fx,fy,alfa);


            [min_el_rot1x,min_el_rot1y]=rotate_coord(x_el,y_el,thetaT_i);
            [minim,iminim]=min(min_el_rot1y);
            [min_el_rot1x,min_el_rot1y]=rotate_coord(min_el_rot1x(iminim),min_el_rot1y(iminim),alfa);
            cont_pointx=min_el_rot1x+xc1;
            cont_pointy=min_el_rot1y+yc1;
            %pp1=plot(cont_pointx,cont_pointy,'ro');

            %fp1=quiver(cont_pointx,cont_pointy,fx/400,fy/400,0,'r');
        elseif results.phase(i)==2
            fx=results.lamda3(i);
            fy=results.lamda4(i);
            [fx,fy]=rotate_coord(fx,fy,alfa);


            [min_el_rot1x,min_el_rot1y]=rotate_coord(x_el,y_el,psiT_i);
            [minim,iminim]=min(min_el_rot1y);
            [min_el_rot1x,min_el_rot1y]=rotate_coord(min_el_rot1x(iminim),min_el_rot1y(iminim),alfa);
            cont_pointx=min_el_rot1x+xc2;
            cont_pointy=min_el_rot1y+yc2;
            %pp1=plot(cont_pointx,cont_pointy,'ro');

            %fp1=quiver(cont_pointx,cont_pointy,fx/400,fy/400,0,'r');
            
        end
    
       % Set margins
        max_margin=max([xM,max(el_rot1x),max(el_rot2x)])+parameters.r0/2;
        min_margin=min([xM,min(el_rot1x),min(el_rot2x)])-parameters.r0/2;
        right_plot_margin=plot(min_margin,yM,'w');
        left_plot_margin=plot(min_margin,yM,'w');
      %  Extend floor
        x1_extend_right=line([0,max_margin],[0,max_margin*tan(alfa)],'Color',[0.7,0.7,0.7]);
        x1_extend_left=line([0,min_margin],[0,min_margin*tan(alfa)],'Color',[0.7,0.7,0.7]);
    
       %ylim([-0.2 1.2])
        %xlim([-0.3,1.8])
      %  plot time
        dim = [.2 .5 .3 .3];
        str = ['t=',num2str(results.t(i),'%.2f'),' [s]'];
        tt=annotation('textbox',dim,'String',str,'FitBoxToText','on');
        
%         subplot(2,1,2)
%         thx=thetaK_i*180/pi;
%         psx=psiK_i*180/pi;
%         Uthx=interp1(plot_misc.angles1,plot_misc.U,thx);
%         Upsx=interp1(plot_misc.angles1,plot_misc.U,psx);
%        
%        kth=plot(thx,Uthx,'o','MarkerEdgeColor','none','MarkerFaceColor',[0.3020    0.7490    0.9294],'MarkerSize',10);
%        kps=plot(psx,Upsx,'o','MarkerEdgeColor','none','MarkerFaceColor',[0.4902    0.1804    0.5608],'MarkerSize',10);
       % Add legend
    %    legend([rocker lever comet],{'Rocker','Radius of Instant Rotation','Trajectory'});
    %     thetaU_d(i)
        %psiU_d(i)
       % Save in mov struct
        mov(ii) = getframe(gcf);
    %     pause(1)
      %  Clear for next frame
        if i<length(results.thetaF) && (ti + plot_misc.plot_step < max(results.t))
            pause(plot_misc.plot_step);
            delete(line_L1F);
            delete(line_L1T);
            delete(line_L2F);
            delete(line_L2T);
            delete(rocker1);
            delete(rocker2);
            delete(massM_obj);
            delete(massm1F_obj);
            delete(massm1T_obj);
            delete(massm2F_obj);
            delete(massm2T_obj);
    %        delete(lever);
            delete(right_plot_margin);
            delete(left_plot_margin);
            delete(tt);
            delete(line_f11)
            delete(line_f21)
            delete(line_f12)
            delete(line_f22)
            delete(jk1)
            delete(jk2)
    
            delete(bar1_1)
            delete(bar2_1)
            delete(bar3_1)
            delete(bar4_1)
            delete(bar1_2)
            delete(bar2_2)
            delete(bar3_2)
            delete(bar4_2)
            %delete(pp1)
            %delete(fp1)
%             delete(kth)
%             delete(kps)
        end
    end
end