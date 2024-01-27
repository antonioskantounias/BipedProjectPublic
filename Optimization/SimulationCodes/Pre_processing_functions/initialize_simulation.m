function results = initialize_simulation(IC)
%% initialize_simulation 
% Description:  This function takes as input a IC struct and returns the first results instance.
% 
% Inputs:       IC:             struct in the same form of stateConditions struct augmented with the field xini initial x
%                               vector that the DAE solver reads. Also the field 'below_knee' which contains the tibial angles
%                              	of the robot that are caclulated analytically from the state space.
%
%
% Outputs:    	results:        struct in which all the simulation run results are saved.    
%
% Author: Antonios Kantounias, Ekaterini Smyrli, Email: antonis.kantounias@gmail.com.

    xinit=IC.xinit;
    results.intermediate.xinit=IC.xinit;

    results.t=0;
    results.intermediate.t0=0;
    results.intermediate.xinit=IC.xinit;

    results.phase=1;
    
    results.xH=xinit(1);    results.thetaF=xinit(3);    results.psiF=xinit(5);
    results.xH_d=xinit(7);  results.thetaF_d=xinit(9);  results.psiF_d=xinit(11);
    results.yH=xinit(2);    results.thetaK=xinit(4);    results.psiK=xinit(6);
    results.yH_d=xinit(8);  results.thetaK_d=xinit(10); results.psiK_d=xinit(12);
    
    results.thetaT=IC.below_knee(1);    results.psiT=IC.below_knee(2);
    results.thetaT_d=IC.below_knee(3);  results.psiT_d=IC.below_knee(4);
    
    results.xFem=IC.below_knee(5);
    results.xFem_d=IC.below_knee(6);
    results.yFem=IC.below_knee(7);
    results.yFem_d=IC.below_knee(8);
    results.xTib1=IC.below_knee(9);
    results.xTib1_d=IC.below_knee(10);
    results.yTib1=IC.below_knee(11);
    results.yTib1_d=IC.below_knee(12);
    results.xTib2=IC.below_knee(13);
    results.xTib2_d=IC.below_knee(14);
    results.yTib2=IC.below_knee(15);
    results.yTib2_d=IC.below_knee(16);
    
    results.events.occurancies.HS1          = 0;
    results.events.occurancies.HS2          = 0;
    results.events.occurancies.TO1          = 0;
    results.events.occurancies.TO2          = 0;
    results.events.occurancies.MaxHeight    = 0;
    results.events.intermediates            = struct('HS1', {}, 'HS2', {}, 'TO1', {}, 'TO2', {}, 'MaxHeight', {});
    
end
