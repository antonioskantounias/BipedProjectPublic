function results = run_SSP2TillMaxHeight(simulationParameters,options,results)
%% run_SSP2TillMaxHeight 
% Description:  This function runs the simulation in single stance phase of the foot 2 till the foot1 heel strike occures.
%               Also the function merges the simulation results with previous results.
% 
% Inputs: 	simulationParameters:	simulationParameters:      struct that contains as fields
%                                	1) A struct with all the dimensional model pararameters. (Model) 
%                                 	2) A struct with all the undimensional model parameters. (ModelFactors)
%                                  	3) A struct that contains all the solver parameters. (Solver)
%                                	4) The section plane sturct. (sectionPlane)
%
%           options:            	struct that contains the solver options for each different simulation that
%                                   will be propably executed.
%
%           results:            	struct in which all the simulation run results are saved. As fields you can find:
%                                   results structure can be initialized using the initialize_simulation.m function. (See gaitFunction.m)
%                                   1) A struct that contains the final timestep's state vector of the model in the form that the solver can read. (xinit)
%                                   also the final time step's time is included (t0). (intermidiate)
%                                   2) The simulation's time at each timestep. (t)
%                                   3) The phase of the robot's gait at each timestep. (phase)
%                                   4) The hips location at x direction at each timestep. (xH)
%                                   5) The hips location at y direction at each timestep. (yH)
%                                   6) The femoral angle and the angularar velocity. "theta" corresponds to "foot1" and "psi" corresponds to "foot2". (---F, ---F_d)
%                                   7) The tibial angle and the angularar velocity. "theta" corresponds to "foot1" and "psi" corresponds to "foot2". (---T, ---T_d)
%                                   8) The knee angle and the angularar velocity. "--- = theta" corresponds to "foot1" and " --- = psi" corresponds to "foot2". (---K, ---K_d)
%                                   9) The events the total number of events that has been recorded at the simulation
%                                   and the corresponding intermidiates. (Respectively: events.occurancies and events.intermidiates)
%                                   10) A flag that indicates if the robot has fallen during the simiulation. (fell)
%
% Outputs:  
%
%       	results:            	The previous results structure with latest single stance phase simulation results merged.
%
% Author: Antonios Kantounias - Aikaterini Smyrli, Email: antonis.kantounias@gmail.com  

% Extract data from simulation parameters
parametersModel         = simulationParameters.Model;
parametersSolver      	= simulationParameters.Solver;

if results.fell==0

    % Run the simulation
    try
    	% Try running the simulation with high tolerance
        [tMaxHeightLeg2,xMaxHeightLeg2] = ode15s(@(ti,xi)  SSP_beta14x1(ti,xi,parametersModel), parametersSolver.tspan, results.intermediate.xinit, options.optMaxHeight2);

    catch
     	% In case that the simulation needs better estimation of the initial conditions then reduce the simulations tolerance 
        disp(['Reducing absolute and relative tolerance to ', num2str(parametersSolver.AbsTol2), 'and', num2str(parametersSolver.RelTol2)])
        options.optMaxHeight2.AbsTol = parametersSolver.AbsTol2;
        options.optMaxHeight2.RelTol = parametersSolver.RelTol2;
        [tMaxHeightLeg2,xMaxHeightLeg2] = ode15s(@(ti,xi)  SSP_beta14x1(ti,xi,parametersModel), parametersSolver.tspan, results.intermediate.xinit, options.optMaxHeight2);
        
    end

 	% Merge the results
    results = export_results(tMaxHeightLeg2,xMaxHeightLeg2,parametersModel,results,2);
    
end

% Assign the apex height to the events data
numOfEventOccurance                                        	= results.events.occurancies.MaxHeight + 1;
results.events.occurancies.MaxHeight                        = numOfEventOccurance;
results.events.intermediates(numOfEventOccurance).MaxHeight	= results.intermediate;
results.events.intermediates(numOfEventOccurance).MaxHeight = exportStatesFromXVector(results.events.intermediates(numOfEventOccurance).MaxHeight, results.intermediate.xinit, parametersModel);

end
