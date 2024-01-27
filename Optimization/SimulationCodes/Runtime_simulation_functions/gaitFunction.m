function [stateConditions, results] = gaitFunction(stateConditions, simulationParameters, varargin)
%% gaitFunction 
% Description:  gaitFunction is a function that takes as input the initial condition of the (n)^th steps and returns the state conditions of the (n+1)^th step.
%               In order to run the simulation this function uses also the simulation parameters.
% 
% Inputs:       stateConditions:        struct that contains the ruturn map initial/input state.
%               
%               simulationParameters:   struct that contains all the model and solver parameters
%
% Outputs       stateConditions:        struct that contains the ruturn map output state.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Parameters
p               = inputParser;
p.KeepUnmatched = true;

p.addParameter('numOfIntersections', 1); % Number of section planes intersection during the simulation
p.parse(varargin{:})

numOfIntersections  = p.Results.numOfIntersections;

%% Generate compatible inputs with the other functions
sectionPlane                    = simulationParameters.sectionPlane;
parametersSolver                = simulationParameters.Solver;
parametersSolver.stepnum        = NaN;

% Calculate initial conditions based on the footshape
IC                              = calculate_xinit(stateConditions, simulationParameters, sectionPlane.initialFoot);

% Initialize simulation output
results                         = initialize_simulation(IC);
results.fell                	= 0;

% Define DAE options and solution events
events                        	= define_ADE_events(simulationParameters);
options                         = define_ADE_options(simulationParameters,events);

%% Run the simulation sequence of the gait function
for iIntersection = 1 : numOfIntersections
    
    try
        results                       	= sectionPlane.runReturnSequence(simulationParameters, options, results);
        
    catch ME
        errorStateConditions        = stateConditions;
        errorSimulationParameters   = simulationParameters;
        errorSectionplane           = sectionPlane;
        save('errorCondtions', 'errorStateConditions', 'errorSimulationParameters', 'errorSectionplane')
        rethrow(ME)
        
    end
    
    stateConditions     = extractStateConditionsFromResults(results);
    
    % In case the gait is symmetric interchange the state conditions extracted
    switch sectionPlane.Name
        case{'AH'}
            stateConditions     = interchangeFootCondition(stateConditions);
        case{'AH2'}
            % Continiue
    end
    
end

end

