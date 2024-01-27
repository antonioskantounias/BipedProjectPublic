function events = define_ADE_events(simulationParameters)
%% define_ADE_events 
% Description: This function is used to define the event function handles based on a specific set of parameters.
% 
% Inputs:       simulationParameters:   struct that contains as fields
%                                       1) A struct with all the dimensional model pararameters. (Model) 
%                                       2) A struct that contains all the solver parameters. (Solver)
%                                       3) The section plane sturct. (sectionPlane)
%
% Outputs:    	events:                 struct that contains the function handles of all the event equations
%                                       for a specific set of model parameters.  
%
% Author: Antonios Kantounias, Ekaterini Smyrli, Email: antonis.kantounias@gmail.com.

% Extract the model parameters
parametersModel  = simulationParameters.Model;

% Load the event functions
events.hs1 = @(t, x) HS_leg1(t,x,parametersModel);
events.hs2 = @(t, x) HS_leg2(t,x,parametersModel);

events.to1 = @(t, x) TO_leg1(t,x,parametersModel);
events.to2 = @(t, x) TO_leg2(t,x,parametersModel);

events.maxHeightEvent = @(t, x) maxHeightEvent(t,x,parametersModel);
    
end
