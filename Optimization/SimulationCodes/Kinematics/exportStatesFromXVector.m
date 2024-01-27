function [eventStructure] = exportStatesFromXVector(eventStructure, xVector, parameters)
    
    % Parameters
    l1=parameters.l1;
    l2=parameters.l2;
    l3=parameters.l3;
    l4=parameters.l4;
    ksiF=parameters.ksiF;
    ksiT=parameters.ksiT;    

    % Export states
    eventStructure.xH           = xVector(1);
    eventStructure.yH           = xVector(2);
    eventStructure.thetaF       = xVector(3);
    eventStructure.thetaK       = xVector(4);
    eventStructure.psiF         = xVector(5);
    eventStructure.psiK         = xVector(6);

    eventStructure.xH_d         = xVector(7);
    eventStructure.yH_d         = xVector(8);
    eventStructure.thetaF_d    	= xVector(9);
    eventStructure.thetaK_d     = xVector(10);
    eventStructure.psiF_d       = xVector(11);
    eventStructure.psiK_d       = xVector(12);

    eventStructure.thetaT       = thetaT_calc(ksiF,ksiT,l1,l2,l3,l4,eventStructure.thetaF,eventStructure.thetaK);
    eventStructure.psiT         = psiT_calc(ksiF,ksiT,l1,l2,l3,l4,eventStructure.psiF,eventStructure.psiK);
    eventStructure.thetaT_d     = thetaT_d_calc(l1,l2,l3,l4,eventStructure.thetaK,eventStructure.thetaF_d,eventStructure.thetaK_d);
    eventStructure.psiT_d       = psiT_d_calc(l1,l2,l3,l4,eventStructure.psiK,eventStructure.psiF_d,eventStructure.psiK_d);
    
end