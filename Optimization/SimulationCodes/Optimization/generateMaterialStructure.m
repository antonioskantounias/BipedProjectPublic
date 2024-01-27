function Material = generateMaterialStructure(materialName)
%% generateMaterialStructure 
% Description: This function generates the material structure base on the material name.
% 
% Inputs:   materialName:   char array that indicates the material name of a link. From the material name the usefull material
%                           characteristics can be extracted.
%
% Outputs:  Material:       struct that contains all the material related information. As fields you can find
%                           1) The material's name. (name)
%                           2) The material's density [kg/m^3].(material density)
%                           3) The yield strength of the material [Pa]. (StrengthYield)
%                           4) The ultimate strength of the material [Pa]. (StrengthUltimate)
%                           5) The material's young modulus [Pa]. (YoungModulus)
%                           6) The material's Poisson ration. (PoissonRatio)
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

switch materialName
    
    case {'Aluminum'}
        Material.Name               = 'Aluminum';
        Material.Density            = 2700; % [kg/m^3]
        Material.StrengthYield      = 276*1e6; % [Pa] % 6061-T6
        Material.StrengthUltimate   = 310*1e6; % [Pa]
        Material.YoungModulus       = 68.9*1e9; % [Pa]
        Material.PoissonsRatio      = 0.33;
        
    case {'Derlin2700'}
        Material.Name               = 'Derlin2700';
        Material.Density            = 1410; % [kg/m^3]
        Material.StrengthYield      = 63*1e6; % [Pa] % Derlin 2700 NC010
        Material.StrengthUltimate   = 63*1e6; % [Pa]
        Material.YoungModulus       = 2.9*1e9; % [Pa]
        Material.PoissonsRatio      = 0.3;
        
	case {'ABS'}
        Material.Name               = 'ABS';
        Material.Density            = 1020; % [kg/m^3]
        Material.StrengthYield      = 63*1e6; % [Pa] % Derlin 2700 NC010
        Material.StrengthUltimate   = 63*1e6; % [Pa]
        Material.YoungModulus       = 2*1e9; % [Pa]
        Material.PoissonsRatio      = 0.394;
        
    case {'CarbonFiber'}
        Material.Name               = 'CarbonFiber';
        Material.Density            = 1414; % [kg/m^3]
        Material.StrengthYield      = 1.5*1e9; % [Pa]
        Material.StrengthUltimate   = 1.5*1e9; % [Pa]
    	Material.YoungModulus       = 300*1e9; % [Pa]
        Material.PoissonsRatio      = 0.3;

    case {'NoMat'}
        Material.Name               = 'NoMat';
        Material.Density            = 1e-6; % [kg/m^3]
        Material.StrengthYield      = 1.5*1e9; % [Pa]
        Material.StrengthUltimate   = 1.5*1e9; % [Pa]
    	Material.YoungModulus       = 300*1e9; % [Pa]
        Material.PoissonsRatio      = 0.3;
        
    otherwise 
        errorMessage    = sprintf('Please select a valid material name\n');
        error(errorMessage);
        
end

end

