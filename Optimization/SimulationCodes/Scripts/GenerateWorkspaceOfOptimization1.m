%% GenerateWorkSpaceOfOptimization1 
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
parametersModelFactors.mFFactor     = [0.0304791095281155];
parametersModelFactors.mTFactor     = [0.0104235881111389];

parametersModelFactors.IHFactor     = 0;
parametersModelFactors.IFFactor     = [0.149979704115947];
parametersModelFactors.ITFactor     = [0.157375211083346];

parametersModelFactors.LFFactor     = 0.2727;
parametersModelFactors.lFFactor     = [0.306467156337321];
parametersModelFactors.lTFactor     = [0.552490132578806];
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
initialConditions.q     = [-0.084674387791069,-0.006813649978960,0.192517825331923,0.052663551479367];
initialConditions.qd    = [-0.101940984624863,-0.003192627223274,-0.077902328842780,-0.320694347372359]* sqrt(g/Lall);