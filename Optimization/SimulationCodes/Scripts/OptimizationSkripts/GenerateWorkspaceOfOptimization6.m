%% GenerateWorkSpaceOfOptimization4
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
%% Calculation before the optimization
%% Model parameters
Mall            = 1;
Lall            = 1;%0.55 or 1;
g               = 1;%9.81 or 1;

parametersModelFactors.Mall       	= Mall;
parametersModelFactors.Lall      	= Lall;
parametersModelFactors.g            = g;

% Masses
parametersModelFactors.mFFactor     = 0.187655085258904;
parametersModelFactors.mTFactor     = 0.050812188349981;

parametersModelFactors.IHFactor     = 0;
parametersModelFactors.IFFactor     = 0.151774653126526;
parametersModelFactors.ITFactor     = 0.172160054763380;

parametersModelFactors.LFFactor     = 0.355208890813295;
parametersModelFactors.lFFactor     = 0.333956442277036;
parametersModelFactors.lTFactor     = 0.474742729918531;
parametersModelFactors.lTxFactor    = 0.064008062496133;

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
initialConditions.q     = [-0.084064867333794,-0.008145356365181,0.206154478174955,0.136540634899193];
initialConditions.qd    = [-0.091884385634405,-0.002970344666658,3.350645316002281e-04,-0.242700141219923]* sqrt(g/Lall);