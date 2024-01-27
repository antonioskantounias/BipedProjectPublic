function CrossSection = generateCrossSectionStructure(crossSectionData, varargin)
%% generateCrossSectionStructure 
% Description:  This function takes as inputs the geometryCharacteristics and generates the cross-section
%               structure that contains all the usefull metrics related to the link's cross section.
% 
% Inputs:       crossSectionData    struct that contains the robot's links cross-section data. As fields you can find.
%                                   1) The cross section name. The word 'automatic' in the crossection name, indicates 
%                                   that all the other cross-section data, are calculated automatically and no other inputs
%                                   are required. (crossSectionName)
%                                   As each cross-section is governed by different formulas see generateCrossSectionStructure.m script
%                                   for more details.
%
% Outputs:      CrossSection    	stuct that constains the crossSectionData with some extra calculations as area and area moment of inertia
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Parameters
p = inputParser;
p.addParameter('alias','');

p.parse(varargin{:})
alias   = p.Results.alias;

%% Calculations
crossSectionName    = crossSectionData.crossSectionName;

switch crossSectionName
    
    case {'Rectangular'}
        % Hollow rectangular cross section
        CrossSection.Name           = crossSectionData.crossSectionName;                                    % Name of the cross-section
        
        bOut                        = crossSectionData.bOut;                                                % Outer width dimension [m]
        CrossSection.bOut           = bOut; % [m]
        
        bIn                         = crossSectionData.bIn;                                                 % Inner width dimension [m]
        CrossSection.bIn            = bIn; % [m]
        
        hOut                        = crossSectionData.hOut;                                                % Outer depth dimension [m]
        CrossSection.hOut           = hOut; % [m]
        
        hIn                         = crossSectionData.hIn;                                                 % Inner depth dimension [m]
        CrossSection.hIn            = hIn; % [m]
        
        CrossSection.ILeast         = (min([ (bOut*hOut^3 - bIn*hIn^3)/12, (hOut*bOut^3 - hIn*bIn^3)/12 ])) * 2;  % Minimum area moment of inetia [m^4] ("*2" Correspond to constructions double foot)
        
        CrossSection.Area           = (bOut*hOut - bIn*hIn) * 2;                                                  % Area [m^2] ("*2" Correspond to constructions double foot)
        
        CrossSection.alias          = alias;                                                                % Cross-section alias
        
    case {'Cylindrical_Automatic'}
        
        CrossSection.Name           = crossSectionData.crossSectionName;                                    % Cross-section name
        
    otherwise 
        errorMessage    = sprintf('Please select a valid cross section name\n');
        error(errorMessage);
        
end

end