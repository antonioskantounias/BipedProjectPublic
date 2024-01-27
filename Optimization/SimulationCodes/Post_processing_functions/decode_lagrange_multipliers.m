function results = decode_lagrange_multipliers(parameters,footshape,results,plot_results)
% %Ground force calculation

    for i=1:1:length(results.thetaF)
    
        xH_i=results.xH(i);
        yH_i=results.yH(i);
        thetaF_i = results.thetaF(i);
        thetaK_i = results.thetaK(i);
        psiF_i = results.psiF(i);
        psiK_i = results.psiK(i);
    
        xH_di=results.xH_d(i);
        yH_di=results.yH_d(i);
        thetaF_di = results.thetaF_d(i);
        thetaK_di = results.thetaK_d(i);
        psiF_di = results.psiF_d(i);
        psiK_di = results.psiK_d(i);
    
        xi=[xH_i,yH_i,thetaF_i,thetaK_i,psiF_i,psiK_i,xH_di,yH_di,thetaF_di,thetaK_di,psiF_di,psiK_di]';
        %
        % qi=x(1:6);
        qdoti=[xi(7:12)];
    
        if results.phase(i)==1
            L6x2=Lamda1_J(xi,parameters,footshape);
            Ld6x2=Lamda1_dot_J(xi,parameters,footshape);
            LT2x6=L6x2.';
    
            Matrix_M6x6=mass6x6(xi,parameters);
            matrixB6x1=beta6x1(xi,parameters);
            invM6x6=(Matrix_M6x6)\eye(6);
    
            lamdas2x1=-inv(LT2x6*invM6x6*L6x2)*((Ld6x2.')*qdoti+LT2x6*invM6x6*matrixB6x1);
            results.lamda1(i)=lamdas2x1(1);
            results.lamda2(i)=lamdas2x1(2);
            results.lamda3(i)=0;
            results.lamda4(i)=0;
            qdd=invM6x6*(matrixB6x1+L6x2*lamdas2x1);
            results.qdotdot(:,i)=qdd;

        elseif results.phase(i)==2
            L6x2=Lamda2_J(xi,parameters,footshape);
            Ld6x2=Lamda2_dot_J(xi,parameters,footshape);
            LT2x6=L6x2.';
    
            Matrix_M6x6=mass6x6(xi,parameters);
            matrixB6x1=beta6x1(xi,parameters);
            invM6x6=(Matrix_M6x6)\eye(6);
    
            lamdas2x1=-inv(LT2x6*invM6x6*L6x2)*((Ld6x2.')*qdoti+LT2x6*invM6x6*matrixB6x1);
            results.lamda1(i)=0;
            results.lamda2(i)=0;
            results.lamda3(i)=lamdas2x1(1);
            results.lamda4(i)=lamdas2x1(2);
            qdd=invM6x6*(matrixB6x1+L6x2*lamdas2x1);
            results.qdotdot(:,i)=qdd;

        else
            L6x4=Lamda_J(xi,parameters,footshape);
            Ld6x4=Lamda_dot_J(xi,parameters,footshape);
            LT4x6=L6x4.';
    
            Matrix_M6x6=mass6x6(xi,parameters);
            matrixB6x1=beta6x1(xi,parameters);
            invM6x6=(Matrix_M6x6)\eye(6);
    
            lamdas4x1=-inv(LT4x6*invM6x6*L6x4)*((Ld6x4.')*qdoti+LT4x6*invM6x6*matrixB6x1);
            results.lamda1(i)=lamdas4x1(1);
            results.lamda2(i)=lamdas4x1(2);
            results.lamda3(i)=lamdas4x1(3);
            results.lamda4(i)=lamdas4x1(4);
            qdd=invM6x6*(matrixB6x1+L6x4*lamdas4x1);
            results.qdotdot(:,i)=qdd;
        end
    end
    
    if plot_results==1
        figure
        plot(results.t,results.lamda2)
        hold on
        plot(results.t,results.lamda4)
        title('Ground Reaction Forces')
        xlabel('t [s]')
        ylabel('GRF [N]')
        % plot(t,phase*100)
    end
    
end