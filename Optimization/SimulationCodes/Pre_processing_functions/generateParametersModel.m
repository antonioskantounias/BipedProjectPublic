function parametersModel    = generateParametersModel(parametersModelFactors)
%% generateParametersModel 
% Description:  This function takes as input the non-dimensional model factors and based on
%               total mass, total length and gravitational acceleration generates the dimensional
%               model parameters.
% 
% Inputs:       parametersModelFactors: struct that contains all the non dimensional model parameters.
%
% Outputs:      parametersModel:        struct that contains the dimensional model parameters.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Parameters
Mall    = parametersModelFactors.Mall;
Lall    = parametersModelFactors.Lall;
g       = parametersModelFactors.g;

parametersModel.m1F      = parametersModelFactors.mFFactor * Mall;
parametersModel.m1T      = parametersModelFactors.mTFactor * Mall;
parametersModel.M        = parametersModelFactors.mHFactor * Mall;  

parametersModel.L1F   	= parametersModelFactors.LFFactor * Lall;
parametersModel.L1T     = parametersModelFactors.LTFactor * Lall;
parametersModel.l1F     = parametersModelFactors.lFFactor * parametersModel.L1F;
parametersModel.l1T     = parametersModelFactors.lTFactor * parametersModel.L1T;
parametersModel.l1Tx    = parametersModelFactors.lTxFactor * parametersModel.L1T;

parametersModel.I        = parametersModelFactors.IHFactor * parametersModel.M * Lall^2;
parametersModel.I1F      = parametersModelFactors.IFFactor * parametersModel.m1F * parametersModel.L1F^2;  
parametersModel.I1T      = parametersModelFactors.ITFactor * parametersModel.m1T * parametersModel.L1T^2;  


% Generate symmetrical robot
parametersModel.m2F      = parametersModel.m1F;  	
parametersModel.I2F      = parametersModel.I1F;                  
parametersModel.L2F      = parametersModel.L1F;        
parametersModel.l2F      = parametersModel.l1F;      
parametersModel.m2T      = parametersModel.m1T;   	
parametersModel.I2T      = parametersModel.I1T;                  
parametersModel.L2T      = parametersModel.L1T;        
parametersModel.l2T      = parametersModel.l1T;   
parametersModel.l2Tx     = parametersModel.l1Tx;

% 4Bar parameters
parametersModel.l1       = parametersModelFactors.l1Factor * Lall; 
parametersModel.l2       = parametersModelFactors.l2Factor * Lall; 
parametersModel.l3       = parametersModelFactors.l3Factor * Lall; 
parametersModel.l4       = parametersModelFactors.l4Factor * Lall; 
parametersModel.l5       = parametersModelFactors.l5Factor * parametersModel.l1; 
parametersModel.l6       = parametersModelFactors.l6Factor * parametersModel.l3;
parametersModel.ksiF     = parametersModelFactors.ksiFAngle/180*pi;
parametersModel.ksiT     = parametersModelFactors.ksiTAngle/180*pi;

% Enviromental parameters
parametersModel.alfa     = parametersModelFactors.alfaAngle / 180 * pi;    
parametersModel.g        = parametersModelFactors.g;

% Knee cap parameters
parametersModel.k                = parametersModelFactors.kFactor * Mall * g * Lall;
parametersModel.b                = parametersModelFactors.bFactor * Mall * sqrt(g) * Lall^(3/2);
parametersModel.knee_cap_angle   = parametersModelFactors.knee_cap_angle * pi / 180;

% Foot parameters
er                        	= parametersModelFactors.er;
R                        	= parametersModelFactors.footsizeFactor * Lall;
footShapePath               = parametersModelFactors.footShapePath;
footshape               	= create_footshape(er*180/pi,R,footShapePath);
[~,ix]                      = min(abs(footshape.x));
parametersModel.r0         	= abs(footshape.y(ix));
parametersModel.footshape 	= footshape;

end

