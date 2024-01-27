function results = extractFootClearance(results, simulationParameters)
%% extractFootClearance 
% Description:  This function takes as input the simulation results structure and the parameters of the robot
%               and calculates data related to the robot's foot clearance through the simulation
% 
% Inputs:       results:                struct in which all the simulation run results are saved. As fields you can find:
%                                       1) A struct that contains the final timestep's state vector of the model in the form that the solver can read. (xinit)
%                                       also the final time step's time is included (t0). (intermidiate)
%                                       2) The simulation's time at each timestep. (t)
%                                       3) The phase of the robot's gait at each timestep. (phase)
%                                       4) The hips location at x direction at each timestep. (xH)
%                                       5) The hips location at y direction at each timestep. (yH)
%                                       6) The femoral angle and the angularar velocity. "theta" corresponds to "foot1" and "psi" corresponds to "foot2". (---F, ---F_d)
%                                       7) The tibial angle and the angularar velocity. "theta" corresponds to "foot1" and "psi" corresponds to "foot2". (---T, ---T_d)
%                                   	8) The knee angle and the angularar velocity. "--- = theta" corresponds to "foot1" and " --- = psi" corresponds to "foot2". (---K, ---K_d)
%                                   	9) The events the total number of events that has been recorded at the simulation
%                                       and the corresponding intermidiates. (Respectively: events.occurancies and events.intermidiates)
%                                       10) A flag that indicates if the robot has fallen during the simiulation. (fell)
%
%               simulationParameters: 	simulationParameters:      struct that contains as fields
%                                    	1) A struct with all the dimensional model pararameters. (Model) 
%                                       2) A struct with all the undimensional model parameters. (ModelFactors)
%                                       3) A struct that contains all the solver parameters. (Solver)
%                                       4) The section plane sturct. (sectionPlane)
%
% Outputs:      results:                struct in which all the simulation run results are saved.
%                                       The results structure contains extra foot clearance results in the form of fields such as.
%                                       1) The swing foot's ground clearance calculated at each timestep. (footClearance)
%                                       2) The swing foot's location in the x direction at each timestep. (footClearanceXLocation)
%                                       3) The swing foot's distance traveled. (footSwingDistanceTraveled)
%                                       4) The swing foot's ground clearance time derivative at each timestep. (footClearanceRate)
%                                       5) The swing foot's mean clearance with respect to the distance traveled. (footMeanClearance)
%                                       6) The swing foot's clearance local minimums. (footClearanceLocalMinimums)
%                                       7) The swing foot's clearance local minimums (indexesfootClearanceLocalMinimumIdxs)
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Calculations
% Initialize the data
numOfSimulationTimeSteps    = length(results.t);
footClearance            	= zeros(1, numOfSimulationTimeSteps);
footClearanceXLocation      = zeros(1, numOfSimulationTimeSteps);
footSwingDistanceTraveled   = zeros(1, numOfSimulationTimeSteps);

% For each time step calculate the foot clearance related data
for iSimulationTimeStep = 1 : numOfSimulationTimeSteps
    
    phase                                       = results.phase(iSimulationTimeStep);
    yH                                          = results.yH(iSimulationTimeStep);
    xH                                          = results.xH(iSimulationTimeStep);
    thetaK                                      = results.thetaK(iSimulationTimeStep);
    thetaF                                      = results.thetaF(iSimulationTimeStep);
    psiK                                        = results.psiK(iSimulationTimeStep);
    psiF                                        = results.psiF(iSimulationTimeStep);
    
    [ifootClearance, ifootClearanceXLocation]  	= calculateFootClearance(simulationParameters, phase, yH, xH, thetaK, thetaF, psiK, psiF);
    footClearance(iSimulationTimeStep)          = ifootClearance;
    footClearanceXLocation(iSimulationTimeStep)	= ifootClearanceXLocation;
    
    if iSimulationTimeStep == 1
        continue
    elseif results.phase(iSimulationTimeStep - 1) ~= results.phase(iSimulationTimeStep)
        footSwingDistanceTraveled(iSimulationTimeStep)   =  footSwingDistanceTraveled(iSimulationTimeStep - 1);
        
    elseif results.phase(iSimulationTimeStep - 1) == results.phase(iSimulationTimeStep)
        footSwingDistanceTraveled(iSimulationTimeStep)   =  footSwingDistanceTraveled(iSimulationTimeStep - 1) +...
                                                            abs(footClearanceXLocation(iSimulationTimeStep) - footClearanceXLocation(iSimulationTimeStep - 1));
    end
    
end

% Calculate the mean value of foot clearance for each time step
footMeanClearance                       = array_int(footClearance, footSwingDistanceTraveled, 0) ./ footSwingDistanceTraveled;
footClearanceRate                       = array_diff(footClearance,results.t);

% Find foot clearance local minimums
footClearanceLocalMinimumIdxs           = find( and( (diff(sign(footClearanceRate))~=0), (~isnan(diff(sign(footClearanceRate))) ) ) );
footClearanceLocalMinimums              = footClearance(footClearanceLocalMinimumIdxs);

%% Assign the data to the results structure
results.footClearance                   = footClearance;
results.footClearanceXLocation          = footClearanceXLocation;
results.footSwingDistanceTraveled       = footSwingDistanceTraveled;
results.footClearanceRate            	= footClearanceRate;
results.footMeanClearance               = footMeanClearance;
results.footClearanceLocalMinimums      = footClearanceLocalMinimums;
results.footClearanceLocalMinimumIdxs   = footClearanceLocalMinimumIdxs;

end
