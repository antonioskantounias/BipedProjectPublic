function [results] = export_results(t,x,parameters,results,phase_id)

    % Export states
    xH=x(:,1);
    yH=x(:,2);
    thetaF=x(:,3);
    thetaK=x(:,4);
    psiF=x(:,5);
    psiK=x(:,6);

    xH_d=x(:,7);
    yH_d=x(:,8);
    thetaF_d=x(:,9);
    thetaK_d=x(:,10);
    psiF_d=x(:,11);
    psiK_d=x(:,12);

    t_tot=t + results.intermediate.t0;
    results.t=[results.t; t_tot];
    results.intermediate.t0=max(results.t);

    results.xH=[results.xH; xH];
    results.yH=[results.yH; yH];

    results.xH_d=[results.xH_d; xH_d];
    results.yH_d=[results.yH_d;yH_d];

    results.thetaF=[results.thetaF;thetaF];
    results.thetaF_d=[results.thetaF_d;thetaF_d];

    results.thetaK=[results.thetaK;thetaK];
    results.thetaK_d=[results.thetaK_d;thetaK_d];

    results.psiF=[results.psiF;psiF];
    results.psiF_d=[results.psiF_d;psiF_d];

    results.psiK=[results.psiK;psiK];
    results.psiK_d=[results.psiK_d;psiK_d];


    L1F=parameters.L1F;
    L2F=parameters.L2F;
    l1=parameters.l1;
    l2=parameters.l2;
    l3=parameters.l3;
    l4=parameters.l4;
    l5=parameters.l5;
    l6=parameters.l6;
    ksiF=parameters.ksiF;
    ksiT=parameters.ksiT;
    
    results.thetaT=[results.thetaT;thetaT_calc(ksiF,ksiT,l1,l2,l3,l4,thetaF,thetaK)];
    results.psiT=[results.psiT;psiT_calc(ksiF,ksiT,l1,l2,l3,l4,psiF,psiK)];
    results.thetaT_d=[results.thetaT_d;thetaT_d_calc(l1,l2,l3,l4,thetaK,thetaF_d,thetaK_d)];
    results.psiT_d=[results.psiT_d;psiT_d_calc(l1,l2,l3,l4,psiK,psiF_d,psiK_d)];
    
    results.xFem=[results.xFem;xFem_calc(xH)];
    results.xFem_d=[results.xFem_d;xFem_d_calc(xH_d)];
    results.yFem=[results.yFem;yFem_calc(yH)];
    results.yFem_d=[results.yFem_d;yFem_d_calc(yH_d)];
    
    results.xTib1=[results.xTib1;xTib1_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF,thetaK,xH)];
    results.xTib1_d=[results.xTib1_d; xTib1_d_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF,thetaK,thetaF_d,thetaK_d,xH_d)];
    results.yTib1=[results.yTib1; yTib1_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF,thetaK,yH)];
    results.yTib1_d=[results.yTib1_d;yTib1_d_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF,thetaK,thetaF_d,thetaK_d,yH_d)];

  	results.xTib2=[results.xTib2;xTib2_calc(L2F,ksiF,l1,l2,l3,l4,l5,l6,psiF,psiK,xH)];
    results.xTib2_d=[results.xTib2_d; xTib2_d_calc(L2F,ksiF,l1,l2,l3,l4,l5,l6,psiF,psiK,psiF_d,psiK_d,xH_d)];
    results.yTib2=[results.yTib2; yTib2_calc(L2F,ksiF,l1,l2,l3,l4,l5,l6,psiF,psiK,yH)];
    results.yTib2_d=[results.yTib2_d; yTib2_d_calc(L2F,ksiF,l1,l2,l3,l4,l5,l6,psiF,psiK,psiF_d,psiK_d,yH_d)];

    results.phase=[results.phase;phase_id*ones(size(thetaF))];

    qi=x(end,1:6);
    qdoti=x(end,7:12);
    results.intermediate.xinit=[qi,qdoti,0,0]';

end