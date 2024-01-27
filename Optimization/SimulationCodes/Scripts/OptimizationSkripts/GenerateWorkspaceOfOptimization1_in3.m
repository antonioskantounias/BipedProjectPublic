%% GenerateWorkspaceOfOptimization1_in2 
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
Mall            = 1;%21 or 1;
Lall            = 1;%0.55 or 1;
g               = 1;%9.81 or 1;

parametersModelFactors.Mall       	= Mall;
parametersModelFactors.Lall      	= Lall;
parametersModelFactors.g            = g;

% Masses
parametersModelFactors.mFFactor     = [0.0304791095281155]*(1+1);
parametersModelFactors.mTFactor     = [0.0304235881111389]*1.3;

parametersModelFactors.IHFactor     = 0;
parametersModelFactors.IFFactor     = [0.149979704115947]/(2);
parametersModelFactors.ITFactor     = [0.257375211083346]*(4);

parametersModelFactors.LFFactor     = [0.303180041448850]*(1+0.4);
parametersModelFactors.lFFactor     = [0.256467156337321];
parametersModelFactors.lTFactor     = [0.552490132578806]-(-0.1);
parametersModelFactors.lTxFactor    = 0.0369;


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
initialConditions.q     = [-0.080145117626592,-0.014276401122425,0.200076493440735,0.103165760579832];
initialConditions.qd    = [-0.057089584779158,-0.002891635194210,-0.043288740991009,-0.209363176862739]* sqrt(g/Lall);