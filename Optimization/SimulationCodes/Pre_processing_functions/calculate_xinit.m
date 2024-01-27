function [IC] = calculate_xinit(stateConditions, simulationParameters, initialFoot)
%% calculate_xinit 
% Description:  This function takes as input conditions and initializes the complete state space vector of the robot.
% 
% Inputs:       stateConditions:        struct that contains the reduced robot's state in the form of
%                                       angular displacements and velocities. stateConditions.q = [thetaF, thetaK, psiF, psiK]
%                                       stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d]
%
%               simulationParameters:   struct that contains as fields
%                                       1) A struct with all the dimensional model pararameters. (Model) 
%                                       2) A struct that contains all the solver parameters. (Solver)
%                                       3) The section plane sturct. (sectionPlane)
%
%               initialFoot:            Index that indicates which foot is in stance at the section plane space.
%
% Outputs:    	IC:                     struct in the same form of stateConditions struct augmented with the field xini initial x
%                                       vector that the DAE solver reads. Also the field 'below_knee' which contains the tibial angles
%                                       of the robot that are caclulated analytically from the state space.
%
% Author: Antonios Kantounias, Ekaterini Smyrli, Email: antonis.kantounias@gmail.com.

parametersModel = simulationParameters.Model;
%%  Calculate angular dofs
    footshape = parametersModel.footshape;
    L1F=parametersModel.L1F;     L1T=parametersModel.L1T;
    L2F=parametersModel.L2F;     L2T=parametersModel.L2T;
    l1=parametersModel.l1;       l2=parametersModel.l2;       l3=parametersModel.l3;   l4=parametersModel.l4;   l5=parametersModel.l5;   l6=parametersModel.l6;
    ksiF=parametersModel.ksiF;   ksiT=parametersModel.ksiT;
    
    thetaF0=stateConditions.q(1);
    thetaK0=stateConditions.q(2);
    psiF0=stateConditions.q(3);
    psiK0=stateConditions.q(4);
    
    thetaF_d0=stateConditions.qd(1);
    thetaK_d0=stateConditions.qd(2);
    psiF_d0=stateConditions.qd(3);
    psiK_d0=stateConditions.qd(4);
    
    thetaT0 = thetaT_calc(ksiF,ksiT,l1,l2,l3,l4,thetaF0,thetaK0);
    thetaT_d0 = thetaT_d_calc(l1,l2,l3,l4,thetaK0,thetaF_d0,thetaK_d0);
    psiT0 = psiT_calc(ksiF,ksiT,l1,l2,l3,l4,psiF0,psiK0);
    psiT_d0= psiT_d_calc(l1,l2,l3,l4,psiK0,psiF_d0,psiK_d0);
    
    %% Calculate hip height based on wich foot is in sigle stance phase
    switch initialFoot

        case {1}
            cx0=0;
            cy0=sin(-thetaT0-interp1(footshape.psi,footshape.fi,thetaT0))*interp1(footshape.psi,footshape.r,thetaT0);
            cx_d0=interp1(footshape.psi,footshape.dc2x_dps,thetaT0)*thetaT_d0;
            cy_d0=interp1(footshape.psi,footshape.dc2y_dps,thetaT0)*thetaT_d0;
            
            c1xH0 = c1x_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF0,thetaK0,0);
            c1yH0 = c1y_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF0,thetaK0,0);
            c1x_dH0 = c1x_d_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF0,thetaK0,thetaF_d0,thetaK_d0,0);
            c1y_dH0 = c1y_d_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF0,thetaK0,thetaF_d0,thetaK_d0,0);

        case {2}
            cx0=0;
            cy0=sin(-psiT0-interp1(footshape.psi,footshape.fi,psiT0))*interp1(footshape.psi,footshape.r,psiT0);
            cx_d0=interp1(footshape.psi,footshape.dc2x_dps,psiT0)*psiT_d0;
            cy_d0=interp1(footshape.psi,footshape.dc2y_dps,psiT0)*psiT_d0;
            
            c1xH0 = c1x_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF0,psiK0,0);
            c1yH0 = c1y_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF0,psiK0,0);
            c1x_dH0 = c1x_d_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF0,psiK0,psiF_d0,psiK_d0,0);
            c1y_dH0 = c1y_d_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF0,psiK0,psiF_d0,psiK_d0,0);
            
        otherwise
            errorMessage = sprintf('Please specify which foot is on single stance phase \n');
            error(errorMessage);

    end
    
    %% Calculate cartesian dofs
    xH0 = cx0-c1xH0;      xH_d0 = cx_d0-c1x_dH0;
    yH0 = cy0-c1yH0;      yH_d0 = cy_d0-c1y_dH0;
    
 	xFem0 = xFem_calc(xH0);
    xFem_d0 = xFem_d_calc(xH_d0);
    yFem0 = yFem_calc(yH0);
    yFem_d0 = yFem_d_calc(yH_d0);
    
    xTib10 = xTib1_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF0,thetaK0,xH0);
    xTib1_d0 = xTib1_d_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF0,thetaK0,thetaF_d0,thetaK_d0,xH_d0);
    yTib10 = yTib1_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF0,thetaK0,yH0);
    yTib1_d0 = yTib1_d_calc(L1F,ksiF,l1,l2,l3,l4,l5,l6,thetaF0,thetaK0,thetaF_d0,thetaK_d0,yH_d0);

  	xTib20 = xTib2_calc(L2F,ksiF,l1,l2,l3,l4,l5,l6,psiF0,psiK0,xH0);
    xTib2_d0 = xTib2_d_calc(L2F,ksiF,l1,l2,l3,l4,l5,l6,psiF0,psiK0,psiF_d0,psiK_d0,xH_d0);
    yTib20 = yTib2_calc(L2F,ksiF,l1,l2,l3,l4,l5,l6,psiF0,psiK0,yH0);
    yTib2_d0 = yTib2_d_calc(L2F,ksiF,l1,l2,l3,l4,l5,l6,psiF0,psiK0,psiF_d0,psiK_d0,yH_d0);
    
    %% Generate x vector
    xinit                           = [xH0,yH0,thetaF0,thetaK0,psiF0,psiK0,xH_d0,yH_d0,thetaF_d0,thetaK_d0,psiF_d0,psiK_d0,0,0]';
    IC               = stateConditions;
    IC.xinit         = xinit;
    IC.below_knee    =[thetaT0, psiT0, thetaT_d0, psiT_d0, xFem0, xFem_d0, yFem0, yFem_d0, xTib10, xTib1_d0, yTib10, yTib1_d0, xTib20, xTib2_d0, yTib20, yTib2_d0];

end