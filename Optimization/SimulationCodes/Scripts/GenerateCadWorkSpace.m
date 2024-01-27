%% GenerateCadWorkSpace 
% Description:
% 
% Outputs:      simulationParameters:   
%
%
%               initialConditions:
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

clear
%% Main dimensions
Lall                                = 0.55;
g                                   = 9.80665;

%% Model parameters

parametersModel.m1F                 = 1.164607936712014;
parametersModel.m1T                 = 0.320735543940845;
parametersModel.M                   = 3.076134276208885;
parametersModel.L1F                 = 0.161769011275916;
parametersModel.L1T                 = 0.388230988724084;
parametersModel.l1F                 = 0.054731373860312;
parametersModel.l1T                 = 0.182878463746803;
parametersModel.l1Tx                = 0.020532738714061;
parametersModel.I                   = 0;
parametersModel.I1F                 = 0.004533278406206;
parametersModel.I1T                 = 0.008219212884935;

parametersModel.m2F                 = 1.164607936712014;
parametersModel.m2T                 = 0.320735543940845;
parametersModel.M                   = 3.076134276208885;
parametersModel.L2F                 = 0.161769011275916;
parametersModel.L2T                 = 0.388230988724084;
parametersModel.l2F                 = 0.054731373860312;
parametersModel.l2T                 = 0.182878463746803;
parametersModel.l2Tx                = 0.020532738714061;
parametersModel.I                   = 0;
parametersModel.I2F                 = 0.004533278406206;
parametersModel.I2T                 = 0.008219212884935;

parametersModel.Mall               	= parametersModel.M + parametersModel.m1F + parametersModel.m2F + parametersModel.m1T + parametersModel.m2T;

parametersModel.l1                  = 0.048500000000000;
parametersModel.l2                  = 0.051500000000000;
parametersModel.l3                	= 0.030000000000000;
parametersModel.l4               	= 0.051000000000000;
parametersModel.l5                  = 0.024250000000000;
parametersModel.l6               	= 0.015000000000000;
parametersModel.ksiF                = 0.436332312998582;
parametersModel.ksiT                = 1.221730476396031;

parametersModel.alfa              	= -0.010471975511966;
parametersModel.g                   = 9.80665;
parametersModel.k                	= 3.354259220373600e+02;
parametersModel.b                	= 9.488259092904556;
parametersModel.knee_cap_angle      = 0;
parametersModel.r0                  = 1.478247562487447e-05;

% Foot parameters
footShapePath                       = 'Footshape\footshape3.mat';
footsizeFactor                      = 0.2;
er                                  = 0.3662;

R                        	= footsizeFactor * Lall;
footshape               	= create_footshape(er*180/pi,R,footShapePath);
[~,ix]                      = min(abs(footshape.x));
parametersModel.r0         	= abs(footshape.y(ix));
parametersModel.footshape 	= footshape;

%% Solver parameters
parametersSolver.tstart         = 0 * sqrt(Lall/g);
parametersSolver.tend           = 2.0218 * sqrt(Lall/g) * 2;
parametersSolver.tspan          = [parametersSolver.tstart,parametersSolver.tend];
parametersSolver.RelTol         = 10^-8;
parametersSolver.AbsTol     	= 10^-8;
parametersSolver.RelTol2        = 10^-5;
parametersSolver.AbsTol2        = 10^-5;
parametersSolver.MaxStep     	= [];% 0.1 , []
parametersSolver.Num_of_steps   = 1 ;
parametersSolver.verbose        = 0;

%% Simulation section plane
sectionPlaneName        = 'AH2';
sectionPlane            = generateSectionPlaneStructure(sectionPlaneName);

%% Assign data to the output structure
simulationParameters.Model          = parametersModel;
simulationParameters.Solver         = parametersSolver;
simulationParameters.sectionPlane   = sectionPlane;

%% Initial Conditions dimensional
initialConditions.q     = [-0.081841998146240,-0.004022780215273,0.175586542133371,0.096518666556217];
initialConditions.qd    = [-0.456276189778151,-0.009269615231244,-0.893922372700816,-1.569958417515053];