function options = define_ADE_options(simulationParameters,events)
%% define_ADE_options 
% Description:  This function generates an options structure that contains the solver options for each
%               simulation part.
% 
% Inputs:   simulationParameters:   struct that contains as fields
%                                   1) A struct with all the dimensional model pararameters. (Model) 
%                                   2) A struct that contains all the solver parameters. (Solver)
%                                   3) The section plane sturct. (sectionPlane)
%
%           events:                 struct that contains the function handles of all the event equations
%                                   for a specific set of model parameters.
%
% Outputs:  options:                struct that contains the solver options for each different simulation that
%                                   will be propably executed.
%
% Author: Aikaterini Smyrli, Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Extract data from simulation parameters
parametersModel     = simulationParameters.Model;
parametersSolver    = simulationParameters.Solver;
footshape           = parametersModel.footshape;

%% SSP1
options.opt_SSP1        = odeset(   'Mass',     @(ti,xi) SSP1_mass14x14(ti,xi,parametersModel,footshape),...
                                    'Events',   events.hs2,...
                                 	'RelTol',   parametersSolver.RelTol,...
                                    'AbsTol',   parametersSolver.AbsTol,...
                                    'MaxStep',  parametersSolver.MaxStep);
                                
%% SSP2
options.opt_SSP2        = odeset(   'Mass',     @(ti,xi) SSP2_mass14x14(ti,xi,parametersModel,footshape),...
                                    'Events',   events.hs1,...
                                 	'RelTol',   parametersSolver.RelTol,...
                                    'AbsTol',   parametersSolver.AbsTol,...
                                    'MaxStep',  parametersSolver.MaxStep);

%% DSP12
options.opt_DSP1        = odeset(   'Mass',     @(ti,xi) DSP_mass16x16(ti,xi,parametersModel,footshape),...
                                    'Events',   events.to1,...
                                    'RelTol',   parametersSolver.RelTol,...
                                    'AbsTol',   parametersSolver.AbsTol,...
                                    'MaxStep',  parametersSolver.MaxStep);

%% DSP21
options.opt_DSP2        = odeset(   'Mass',     @(ti,xi) DSP_mass16x16(ti,xi,parametersModel,footshape),...
                                    'Events',   events.to2,...
                                    'RelTol',   parametersSolver.RelTol,...
                                    'AbsTol',   parametersSolver.AbsTol,...
                                    'MaxStep',  parametersSolver.MaxStep);

%% AH
options.optMaxHeight1   = odeset(   'Mass',     @(ti,xi) SSP1_mass14x14(ti,xi,parametersModel,footshape),...
                                    'Events',   events.maxHeightEvent,...
                                 	'RelTol',   parametersSolver.RelTol,...
                                    'AbsTol',   parametersSolver.AbsTol,...
                                    'MaxStep',  parametersSolver.MaxStep);   
                          
options.optMaxHeight2   = odeset(   'Mass',     @(ti,xi) SSP2_mass14x14(ti,xi,parametersModel,footshape),...
                                    'Events',   events.maxHeightEvent,...
                                    'RelTol',   parametersSolver.RelTol,...
                                    'AbsTol',   parametersSolver.AbsTol,...
                                    'MaxStep',  parametersSolver.MaxStep);   

end
