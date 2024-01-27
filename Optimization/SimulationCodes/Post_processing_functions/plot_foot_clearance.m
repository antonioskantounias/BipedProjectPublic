function results = plot_foot_clearance(parameters,footshape,results,plot_results)

    
    
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

    j=0;
    for i=length(results.thetaK):-1:2
        if results.phase(i)==1 && results.phase(i-1)==2
            j=j+1;
            if j==2
                break
            end
        end
    end


    xH=results.xH(i:end);
    yH=results.yH(i:end);
    psiK=results.psiK(i:end);
    psiF=results.psiF(i:end);
    thetaK=results.thetaK(i:end);
    thetaF=results.thetaF(i:end);


    yc2= c2y_calc(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF,psiK,yH);
    yc1= c1y_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF,thetaK,yH);

    x_el=footshape.x;
    y_el=footshape.y;
    psiT = psiT_calc(ksiF,ksiT,l1,l2,l3,l4,psiF,psiK);
    thetaT = thetaT_calc(ksiF,ksiT,l1,l2,l3,l4,thetaF,thetaK);
    
    [~,el_rot2y]=rotate_coord(x_el,y_el,psiT);
    [~,el_rot1y]=rotate_coord(x_el,y_el,thetaT);
    yel_2=min(el_rot2y,[],2)+yc2;
    yel_1=min(el_rot1y,[],2)+yc1;
    results.foot_clear2=yel_2;
    results.foot_clear1=yel_1;

    
    if plot_results==1
        figure
        tiledlayout(2,1)
        nexttile
        xlabel('t [s]')
        ylabel('Foot clearance')
        plot(results.t(i:end),yel_2)
        grid on
        title('Foot clearance 2')
        
        nexttile
        xlabel('t [s]')
        ylabel('Foot clearance')
        plot(results.t(i:end),yel_1)
        grid on
        title('Foot clearance 1')
        
        figure
        tiledlayout(2,1)
        nexttile
        xlabel('t [s]')
        ylabel('Foot clearance velocity')
        plot(results.t(i:end-1),diff(yel_2)./diff(results.t(i:end)))
        grid on
        title('Foot clearance 2 velocity')
        
        nexttile
        xlabel('t [s]')
        ylabel('Foot clearance velocity')
        plot(results.t(i:end-1),diff(yel_1)./diff(results.t(i:end)))
        grid on
        title('Foot clearance 1 velocity')
        
        
    end
end