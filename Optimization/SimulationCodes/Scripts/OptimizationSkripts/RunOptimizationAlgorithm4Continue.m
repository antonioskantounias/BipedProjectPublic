%% RunOptimizationAlgorithm 4 continue with different optimization parameters
% Description:  This script generates the workspace for the optimization function optimizeWithSteepestDescend.m to run.
%               Then the optimization function runs and the results are saved in external folders.
% 
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Generate workspace
clear
GenerateWorkspaceOfOptimization4

%% Continue from an existing optimization or start a new one
continueOptimization 	= true;    % Flag that indicates if there will be new optimization or will continue from an existing optimization

if continueOptimization
    optimizationFolder      = 'C:\Projects\BipedProject\Optimization\SimulationCodes\OptimizationResults\Optimization4Construction';
    initialIteration        = 15;
    load([optimizationFolder, filesep, 'iterationResults', num2str(initialIteration), '.mat'])
    initialConditions       = iterationResults(1).initialConditions;
    
else
    initialIteration        = 0;
    iterationResults        = struct;
    
end

%% Generate simulation model option
% Insert simulation and model parameters (model factor parameters are valid only when there is no initialization of iteration results)
SimulationModelOptions.simulationParameters                     = simulationParameters;             % Initial simulationParameters         
SimulationModelOptions.initialConditions                        = initialConditions;                % Initial state conditions

% Insert construction characteristics

%%% Cross section calculation automatic---------------------------------------------------------------------------------------------------------------------
% crossSectionDataFemoral.crossSectionName                        = 'Cylindrical_Automatic';          % Cross section type at the femoral link of the byped
% crossSectionDataTibial.crossSectionName                         = 'Cylindrical_Automatic';          % Cross section type at the tibial link of the byped
% beamFemoralData                                                 = struct;
% beamFemoralData                                                 = struct;
%%% --------------------------------------------------------------------------------------------------------------------------------------------------------

%%% Cross section definition based on cad model-------------------------------------------------------------------------------------------------------------
crossSectionDataFemoral.crossSectionName                        = 'Rectangular';                    % Cross section type at the femoral link of the byped
crossSectionDataFemoral.bOut                                    = 31.7*1e-3;                        % Outer width dimension [m]
crossSectionDataFemoral.bIn                                     = 21.7*1e-3;                        % Inner width dimension [m]
crossSectionDataFemoral.hOut                                    = 35*1e-3;                          % Outer depth dimension [m]
crossSectionDataFemoral.hIn                                     = 29*1e-3;                          % Inner depth dimension [m]

crossSectionDataTibial.crossSectionName                         = 'Rectangular';                    % Cross section type at the tibial link of the byped
crossSectionDataTibial.bOut                                     = 20*1e-3;                          % Outer width dimension [m]
crossSectionDataTibial.bIn                                      = 17*1e-3;                           % Inner width dimension [m]
crossSectionDataTibial.hOut                                     = 20*1e-3;                          % Outer depth dimension [m]
crossSectionDataTibial.hIn                                      = 17*1e-3;                           % Inner depth dimension [m]

beamFemoralData.OffsetUp                                        = 28*1e-3;                          % Offset of the upper part of the femoral link from the hip axis. (with possitive direction to the across link edge)
beamFemoralData.OffsetDown                                      = 43.5*1e-3;                        % Offset of the lower part of the femoral link from the knee axis. (with possitive direction to the across link edge)
beamFemoralData.OffsetOut                                       = 0*1e-3;

beamFemoralData.ExtraBodyUp(1).Mass                             = 0.660;                            % Extra body mass [kg]
beamFemoralData.ExtraBodyUp(1).CoM                              = 0.01625861;                         % Extra body center of mass [m] (Zero is considered the theoretical links upper edge with possitive direction to the across edge) 
beamFemoralData.ExtraBodyUp(1).CoMx                             = 0;                                % Extra body center of mass in x direction [m] (Zero is considered the theoretical links edge with possitive direction the gait's direction) 
beamFemoralData.ExtraBodyUp(1).Inertia                          = 0.00138567;                      % Extra body inertia around it's center of mass [kg*m^2]

beamFemoralData.ExtraBodyDown(1).Mass                           = 0.5388;                          % Extra body mass [kg]
beamFemoralData.ExtraBodyDown(1).CoM                            = -(100 - 153.7)*1e-3;            % Extra body center of mass [m] (Zero is considered the theoretical links lower edge with possitive direction to the across edge) 
beamFemoralData.ExtraBodyDown(1).CoMx                           = 0;                                % Extra body center of mass in x direction [m] (Zero is considered the theoretical links edge with possitive direction the gait's direction) 
beamFemoralData.ExtraBodyDown(1).Inertia                        = 0.00053225;                     % Extra body inertia around it's center of mass [kg*m^2]

beamTibialData.OffsetUp                                         = 19*1e-3;                          % Offset of the upper part of the tibial link from the knee axis (with possitive direction to the across link edge)
beamTibialData.OffsetDown                                       = 15.21564962*1e-3;                        % Offset of the lower part of the tibial link from the foot axis (with possitive direction to the across link edge)
beamTibialData.OffsetOut                                        = (13.58434129- (-7.91565871))*1e-3;

beamTibialData.ExtraBodyUp(1).Mass                           	= 0.09581848;                           % Extra body mass [kg]
beamTibialData.ExtraBodyUp(1).CoM                             	= (209.37-194.77)*1e-3;              	% Extra body center of mass [m] (Zero is considered the theoretical links lower edge with possitive direction to the across edge)  
beamTibialData.ExtraBodyUp(1).CoMx                              = (6.62 - (-7.91565871))*1e-3;            	% Extra body center of mass in x direction [m] (Zero is considered the theoretical links edge with possitive direction the gait's direction) 
beamTibialData.ExtraBodyUp(1).Inertia                        	= 0.00005510;                       % Extra body inertia around it's center of mass [kg*m^2]

beamTibialData.ExtraBodyDown(1).Mass                           	= 0.07916513;                          % Extra body mass [kg]
beamTibialData.ExtraBodyDown(1).CoM                         	= -(582.7-591.1)*1e-3;           	% Extra body center of mass [m] (Zero is considered the theoretical links upper part 
beamTibialData.ExtraBodyDown(1).CoMx                          	= (28.9 - (-7.91565871))*1e-3;          	% Extra body center of mass in x direction [m] (Zero is considered the theoretical links edge with possitive direction the gait's direction) 
beamTibialData.ExtraBodyDown(1).Inertia                      	= 0.00005278;                   	% Extra body inertia around it's center of mass [kg*m^2]

%%%---------------------------------------------------------------------------------------------------------------------------------------------------------
materialNameFemoral                                             = 'NoMat';                          % Material at the femoral link of the byped
materialNameTibial                                              = 'CarbonFiber';                  	% Material of the tibial link of the biped

ConstructionParameters.Lall                                     = 0.550;                         	% Total length of the byped [m]
ConstructionParameters.LFFactor                                 = 0.2795;            	% Femoral to total length factor
ConstructionParameters.mHFactor                               	= 0.9;                              % Hip to total mass factor
ConstructionParameters.sFFemoral                              	= 250;                              % Safety to buckling factor for the femoral link
ConstructionParameters.sFTibial                                 = 150;                              % Safety to buckling factor for the tibial link

%%%----------------------------------------------------------------------------------------------------------------------------------------------------------
ConstructionParametersGains.lFFactor    = 2e2;
ConstructionParametersGains.lTFactor    = 2e3;
ConstructionParametersGains.lTxFactor   = 1;
ConstructionParametersGains.mFFactor    = 0.6;
ConstructionParametersGains.mTFactor    = 0.7;
ConstructionParametersGains.IFFactor    = 1.2e3;
ConstructionParametersGains.ITFactor    = 1.3e2;

ConstraintDeviation.lFFactor    = 0.4;
ConstraintDeviation.lTFactor    = 0.1;
ConstraintDeviation.lTxFactor   = 0.1;
ConstraintDeviation.mFFactor    = 0.1;
ConstraintDeviation.mTFactor    = 0.1;
ConstraintDeviation.IFFactor    = 0.1;
ConstraintDeviation.ITFactor    = 0.1;

ConstructionCharacteristics.materialNameFemoral                 = materialNameFemoral;                      
ConstructionCharacteristics.materialNameTibial                  = materialNameTibial;
ConstructionCharacteristics.crossSectionDataFemoral           	= crossSectionDataFemoral;
ConstructionCharacteristics.crossSectionDataTibial            	= crossSectionDataTibial;
ConstructionCharacteristics.beamFemoralData                     = beamFemoralData;
ConstructionCharacteristics.beamTibialData                      = beamTibialData;
ConstructionCharacteristics.ConstructionParameters            	= ConstructionParameters;
ConstructionCharacteristics.ConstructionParametersGains         = ConstructionParametersGains;
ConstructionCharacteristics.ConstraintDeviation                 = ConstraintDeviation;
SimulationModelOptions.ConstructionCharacteristics              = ConstructionCharacteristics;

%% Generate optimization options
% Generate fixed point calculation option
FixedPointCalculationOptions.tol                                = 1e-8;                             % The tolerance of that indicates that the newton raphson method is converged
FixedPointCalculationOptions.max_iter                           = 20;                               % Maximum N.R. iterations
FixedPointCalculationOptions.displayConvergenceProgress         = true;                             % Flag that indicates the convergence progress of N.R. method.
FixedPointCalculationOptions.maximumNoProgressSteps             = 5;                                % The maximum number of step that the N.R. convergence need to have progressed.
FixedPointCalculationOptions.progressRateMinimum              	= 0.5;                              % The minimum progress that must happen after maximumNoProgressSteps.

% Generate jacobian matrix calculation options
JacobianCalculationOptions.perturbation                         = 1e-5;                             % The state variable perturbation in order to calculate the numerically the jacobian.
JacobianCalculationOptions.unconstrainedVariablesToExclude  	= { 'thetaK'                        % State variables that are considered constant and are excluded from the jacobian calculation process.
                                                                    'thetaK_d'};

% Generate cost function options
CostFunctionOptions.evaluateEigenValueMax                       = true;                             % Flag that indicates if the maximum eigen value of the return map will be included into the cost function
CostFunctionOptions.eigenValueMaxPenaltyFactor                  = 0.5;                                % Weight of the maximum eigen value of the return map to the total cost function
CostFunctionOptions.evaluateEigenValueRobustness                = false;                            % Flag that indicates if the maximum eigen value of the return map will be included into the cost function
CostFunctionOptions.eigenValueRobustnessPenaltyFactor           = 1;                                % Weight of the maximum eigen value of the return map to the total cost function
CostFunctionOptions.eigenValueRobustnessVariablePerturbation    = 1e-5;                             % Weight of the maximum eigen value of the return map to the total cost function
CostFunctionOptions.evaluateConstruction                        = true;                             % Flag that indicates if deviations from construction/manufacturing limits will be included into the cost function
CostFunctionOptions.constructionPenaltyFactor                   = 1;                             	% Weight of the deviations from construction/manufacturing limits to the total cost function
CostFunctionOptions.evaluateConstructionMass                    = true;                             
CostFunctionOptions.constructionMassPenaltyFactor               = 2e-1;                             	
CostFunctionOptions.constructionMassDesired                     = 5;
CostFunctionOptions.evaluateMeanFootClearance                   = false;                            % Flag that indicates if the mean foot clearance will be included into the cost function
CostFunctionOptions.meanFootClearancePenaltyFactor              = 1;                                % Weight of the mean foot clearance to the total cost function
CostFunctionOptions.evaluateMinFootClearance                    = true;                             % Flag that indicates if the minimum foot clearance value is included into the cost function
CostFunctionOptions.minFootClearancePenaltyFactor               = 0.5e-3;                           % Weight of the minimum foot clearance to the total cost function

% Generate steepest descend options
SteepestDescendOptions.designFactors                            = { 'LFFactor';                     % Model parameter factors that will be used as design variables for the optimization procedure
                                                                    'lFFactor'
                                                                    'lTFactor'
                                                                    'lTxFactor'
                                                                    'mFFactor'
                                                                    'mTFactor'
                                                                    'IFFactor'
                                                                    'ITFactor'};
SteepestDescendOptions.optimizationName                         = 'Optimization4Construction';   	% Name of the folder that the optimization results will be saved
SteepestDescendOptions.overwriteFolder                          = true;                             % Flag that indicates if the folder will be overwrited if it already exists
SteepestDescendOptions.stepSize                                 = 1e-4;                             % Step size of the parameters. It is related to the parameter gradients with respect to the total cost function.
SteepestDescendOptions.maxIterations                         	= 100;                                % Maximum number of optimization iterations

SteepestDescendOptions.smallGradientNorm                     	= 11;                               % Design variables gradient norm that is considered small
SteepestDescendOptions.numOfConsequtiveSmallGradientNormMax   	= 100;                              % Max number of consequtive small gradient occurance
SteepestDescendOptions.costFunctionSmallProgressRate            = 0.2;                          	% Cost function progress rate that is considered small
SteepestDescendOptions.numOfcostFunctionSmallProgressRateMax   	= 100;                              % Max number of consequtive cost function small progress rate

SteepestDescendOptions.optimizationPerturbation                 = 5e-3;                             % Perturbation of the model parameter factors during the numerical calculation of the gradients
SteepestDescendOptions.gradientLimit                            = 1e2;                              % Maximum gradient for wich the variable step is not permissible.
SteepestDescendOptions.initialIteration                         = initialIteration+1;               % Initial iteration index number. In case there are already some existing optimization cycles
SteepestDescendOptions.iterationResults                         = iterationResults;                 % struct % iterationResults. Optimization can be initialized from an older optization iteration using the corresponding iterationResults structure

% Assign options
OptimizationOptions.FixedPointCalculationOptions                = FixedPointCalculationOptions; 
OptimizationOptions.JacobianCalculationOptions                  = JacobianCalculationOptions;
OptimizationOptions.CostFunctionOptions                         = CostFunctionOptions;
OptimizationOptions.SteepestDescendOptions                    	= SteepestDescendOptions;

%% Run gradient based optimization
optimizeModelWithSteepestDescend(OptimizationOptions, SimulationModelOptions);