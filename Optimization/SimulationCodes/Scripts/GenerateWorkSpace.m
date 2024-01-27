%% GenerateWorkSpace 
% Description:  Generate workspace script contains all the model and the solver parameters.
%               Sets a value to all the non-dimensional model parameters.
%               Sets a value to all the solver parameters.
%               Defines non-dimensional initial conditions of the gait (angles and velocities).
% 
% Outputs:      simulationParameters:   struct with fields 1) [Model] a structure that cotains all the dimensional 
%                                       model pararameters. 2) [Solver] a structure that contains all the solver parameters.
%                                       3) [sectionPlane] a structure that contains all the return map related data.
%
%
%               initialConditions:      struct that contains gait simulations initial conditions (angles and angular velocities). 
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

clear
%% Model parameters
Mall            = 6.0468;%21 or 1;
Lall            = 0.55;%0.55 or 1;
g               = 9.80665;%9.81 or 1;

parametersModelFactors.Mall       	= Mall;
parametersModelFactors.Lall      	= Lall;
parametersModelFactors.g            = g;

% Masses
parametersModelFactors.mFFactor     = [0.192598373751611];
parametersModelFactors.mTFactor     = [0.0530420085765054];

parametersModelFactors.IHFactor     = 0;
parametersModelFactors.IFFactor     = [0.148744865695891];
parametersModelFactors.ITFactor     = [0.170021068873086];

parametersModelFactors.LFFactor     = [0.294125475047120];
parametersModelFactors.lFFactor     = [0.338330397327836];
parametersModelFactors.lTFactor     = [0.471055812282866];
parametersModelFactors.lTxFactor    = [0.0528879438025841];

% 4Bar parameters
parametersModelFactors.l1Factor     = 48.5/550;
parametersModelFactors.l2Factor     = 51.5/550;
parametersModelFactors.l3Factor     = 30/550;
parametersModelFactors.l4Factor     = 51/550;
parametersModelFactors.l5Factor     = 0.5;
parametersModelFactors.l6Factor     = 0.5;
parametersModelFactors.ksiFAngle    = 25;
parametersModelFactors.ksiTAngle    = 180-110;

% Enviromental parameters
parametersModelFactors.alfaAngle 	= -0.6;

% Knee cap parameters
parametersModelFactors.kFactor          = 5.3823;
parametersModelFactors.bFactor          = 0.6430;
parametersModelFactors.knee_cap_angle   = 0;

% Foot parameters
parametersModelFactors.footShapePath    = 'Footshape\footshape3.mat';
parametersModelFactors.footsizeFactor   = 0.2;
parametersModelFactors.er           	= 0.3662;

% Generate dimentional model parameters
parametersModelFactors                  = updateParametersModelFactors(parametersModelFactors);
parametersModel                         = generateParametersModel(parametersModelFactors);

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
sectionPlaneName        = 'AH';
sectionPlane            = generateSectionPlaneStructure(sectionPlaneName);

%% Assign data to the output structure
simulationParameters.Model          = parametersModel;
simulationParameters.ModelFactors   = parametersModelFactors;
simulationParameters.Solver         = parametersSolver;
simulationParameters.sectionPlane   = sectionPlane;

%% Initial Conditions dimensional
initialConditions.q     = [-0.083951923411109,-0.005956329730699,0.203167363850402,0.127449885829746];
initialConditions.qd    = [-0.101199979634522,-0.002802919467637,-0.149606436045619,-0.313727692620294]* sqrt(g/Lall);


