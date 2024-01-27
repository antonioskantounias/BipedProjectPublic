function [footClearance, footClearanceXLocation] = calculateFootClearance(simulationParameters, phase, yH, xH, thetaK, thetaF, psiK, psiF)
%% calculateFootClearance 
% Description:  This function calculateσ the foot clearance for a specific model's state condition 
% 
% Inputs:       simulationParameters: 	simulationParameters:      struct that contains as fields
%                                       1) A struct with all the dimensional model pararameters. (Model) 
%                                       2) A struct with all the undimensional model parameters. (ModelFactors)
%                                       3) A struct that contains all the solver parameters. (Solver)
%                                       4) The section plane sturct. (sectionPlane)
%
%               result structure values: see results structure description. (phase, yH, xH, thetaK, thetaF, psiK, psiF)
%               
% Outputs:      footClearance:          The swing foot's ground clearance calculated at each timestep.
%                                       
%
%               footClearanceXLocation: The swing foot's location in the x direction at each timestep.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Load the models parameters
parametersModel  = simulationParameters.Model;

L1F         = parametersModel.L1F;
L2F         = parametersModel.L2F;
L1T         = parametersModel.L1T;
L2T         = parametersModel.L2T;
l1          = parametersModel.l1;
l2          = parametersModel.l2;
l3          = parametersModel.l3;
l4          = parametersModel.l4;
l5          = parametersModel.l5;
l6          = parametersModel.l6;
ksiF        = parametersModel.ksiF;
ksiT        = parametersModel.ksiT;
footshape   = parametersModel.footshape;

switch phase
    % In case that the "foot1" is in swing phase
    case {1, 12}
        % Calculate the ankle's location at x and y direction
        yc2     = c2y_calc(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF,psiK,yH);
        xc2     = c2x_calc(L2F,L2T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,psiF,psiK,xH);
        
        % Extract and rotate the footshape according to the tibial angle
        x_el                        = footshape.x;
        y_el                        = footshape.y;
        psiT                        = psiT_calc(ksiF,ksiT,l1,l2,l3,l4,psiF,psiK);
        [el_rot2x, el_rot2y]      	= rotate_coord(x_el, y_el, psiT);
        
        % Calculte the lowers part of the foot location
        [footClearance, minIndex]   = min(el_rot2y + yc2);
        footClearanceXLocation      = el_rot2x(minIndex) + xc2;
        
    % In case that the "foot2" is in swing phase
    case {2, 21}
        % Calculate the ankle's location at x and y direction
        yc1     = c1y_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF,thetaK,yH);
        xc1     = c2x_calc(L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,thetaF,thetaK,xH);
        
        % Extract and rotate the footshape according to the tibial angle
        x_el                        = footshape.x;
        y_el                        = footshape.y;
        thetaT                      = thetaT_calc(ksiF,ksiT,l1,l2,l3,l4,thetaF,thetaK);
        [el_rot1x, el_rot1y]        = rotate_coord(x_el, y_el, thetaT);
        
        % Calculte the lowers part of the foot location
        [footClearance, minIndex]   = min(el_rot1y + yc1);
        footClearanceXLocation      = el_rot1x(minIndex) + xc1;
        
    otherwise
        errorMessage = sprintf(['Phase can be equal to 1 (Indicating stance of the foot 1)',...
                                'or 2 (Indicating stance of the foot 2) \n',...
                                'Please select a valid phase index']);
        error(errorMessage);
        
end
    
end