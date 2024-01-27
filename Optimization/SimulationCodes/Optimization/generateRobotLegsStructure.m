function RobotLegs = generateRobotLegsStructure(CrossSectionFemoral, CrossSectionTibial, LengthFemoral, LengthTibial, MaterialFemoral, MaterialTibial, ConstructionCharacteristics)
%% generateRobotLegsStructure 
% Description:  This function generates the final robot's leg structure. The robot's legs consist from beams wich are usefull for the
%               construction robot's model parameters restriction generation.
% 
% Inputs:       CrossSection:           stuct that constains the crossSectionData with some extra calculations as area and area moment of inertia.
%                                       The 'Femoral' suffix indicates the femoral cross-section, the 'Tibial' suffix indicates the tibial cross-section
%
%               Length:                 The beam/links length
%                                       The 'Femoral' suffix indicates the femoral cross-section, the 'Tibial' suffix indicates the tibial cross-section
%               
%               Materail:               struct that contains all the material related information. As fields you can find
%                                       1) The material's name. (name)
%                                       2) The material's density [kg/m^3].(material density)
%                                       3) The yield strength of the material [Pa]. (StrengthYield)
%                                       4) The ultimate strength of the material [Pa]. (StrengthUltimate)
%                                       5) The material's young modulus [Pa]. (YoungModulus)
%                                       6) The material's Poisson ration. (PoissonRatio)
%                                       The 'Femoral' suffix indicates the femoral cross-section, the 'Tibial' suffix indicates the tibial cross-section
%
%               ConstructionParameters:	struct that contains important for the construction base calculation parameters. Those parameters are
%                                      	setted in the form of fields. As field you can find.
%                                     	1) The total length of the robot (Lall).
%                                      	2) The femoral to total length ratio (LFFactor).
%                                     	3) The hip to total mass ratio (mHFactor).
%                                       4) The safety to buckling factor for the femoral link
%                                     	5) The safety to buckling factor for the tibial link
%
% Outputs:
%
%           RobotLegs:                  struct that contains all the robot leg link information. Each leg constitutes from one femoral beam
%                                       and one tibial beam. In the beam stucture contains information in the form of fields. As fields you can find 
%                                       1) A cross section structure. (CrossSection)
%                                       2) A material structure. (Material)
%                                       3) The beams lenght, mass, mass moment of inertia, the center of mass in x and y direction, 
%                                       critical buckling load and aspect ratio. (Length, Mass, MassInertia, CenterOfMassY, CenterOfMassX,
%                                       LoadBuckling, AspectRatio)
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Calculations 
% Generate beam structures
ConstructionParameters  = ConstructionCharacteristics.ConstructionParameters;
beamFemoralData         = ConstructionCharacteristics.beamFemoralData;
beamTibialData          = ConstructionCharacteristics.beamTibialData;

[BeamFemoral, ~]    = generateBeamStructure(CrossSectionFemoral, MaterialFemoral, LengthFemoral, beamFemoralData);
[BeamTibial, ~]     = generateBeamStructure(CrossSectionTibial, MaterialTibial, LengthTibial, beamTibialData);
 
% Update beams and cross section
[BeamFemoral, BeamTibial] = updateBeams(BeamFemoral, BeamTibial, ConstructionParameters);

%% Assign resulted beams to the robot leg structure
RobotLegs.BeamFemoral   = BeamFemoral;
RobotLegs.BeamTibial    = BeamTibial;

end

function [Beam, CrossSection] = generateBeamStructure(CrossSection, Material, Length, beamData, varargin)
%% Parameters
p = inputParser;
p.addParameter('aspectRatio', 0.03); % This parameter is used as initial condition

p.parse(varargin{:})
aspectRatio  = p.Results.aspectRatio;

%% Generate beam structures
switch CrossSection.Name
    case {'Rectangular'}
        % Calculate link characteristics
        offsetUp            = beamData.OffsetUp;                                                    % [m]
        offsetDown          = beamData.OffsetDown;                                                  % [m]
        offsetOut           = beamData.OffsetOut;                                                  % [m]
        LengthLink          = Length - offsetUp - offsetDown;                                       % [m]
        MassLink            = (CrossSection.Area * Material.Density * LengthLink);                  % [kg/m] 
        MassInertiaLink    	= MassLink * LengthLink^2 / 12;                                      	% [kg*m^2]
        CenterOfMassYLink   = offsetUp + LengthLink/2;                                              % [m]
        CenterOfMassXLink  	= offsetOut;                                                          % [m]
        LoadBuckling     	= pi^2 * Material.YoungModulus * CrossSection.ILeast / LengthLink^2; 	% [N]
        AspectRatio         = max(CrossSection.bOut, CrossSection.hOut);
        
        % Calculate beam characteristics
        MassBeam            = MassLink;                                                             % [kg]
        CenterOfMassYBeam   = CenterOfMassYLink;                                                    % [m]
        CenterOfMassXBeam   = CenterOfMassXLink;                                                    % [m]
        MassInertiaBeam     = MassInertiaLink;                                                      % [kg*m^2]
        
        if isfield(beamData, 'ExtraBodyUp')
           numOfExtraBodiesUp = length(beamData.ExtraBodyUp);
           for iExtraBody = 1 : numOfExtraBodiesUp
               ExtraBodyUp          = beamData.ExtraBodyUp(iExtraBody);
               
               MassBeamNew          = MassBeam + ExtraBodyUp.Mass;
               CenterOfMassYBeamNew = (CenterOfMassYBeam*MassBeam + ExtraBodyUp.CoM*ExtraBodyUp.Mass) / (MassBeam + ExtraBodyUp.Mass);
               CenterOfMassXBeamNew = (CenterOfMassXBeam*MassBeam + ExtraBodyUp.CoMx*ExtraBodyUp.Mass) / (MassBeam + ExtraBodyUp.Mass);
               MassInertiaBeamNew   =   MassInertiaBeam + abs(CenterOfMassYBeamNew - CenterOfMassYBeam)^2 * MassBeam +...
                                        ExtraBodyUp.Inertia + abs(CenterOfMassYBeamNew - ExtraBodyUp.CoM)^2 * ExtraBodyUp.Mass;
               
                MassBeam            = MassBeamNew;
                CenterOfMassYBeam   = CenterOfMassYBeamNew;
                CenterOfMassXBeam   = CenterOfMassXBeamNew;
                MassInertiaBeam     = MassInertiaBeamNew;
           end
        end
        
        if isfield(beamData, 'ExtraBodyDown')
           numOfExtraBodiesDown = length(beamData.ExtraBodyDown);
           for iExtraBody = 1 : numOfExtraBodiesDown
               ExtraBodyDown          = beamData.ExtraBodyDown(iExtraBody);
               
               MassBeamNew          = MassBeam + ExtraBodyDown.Mass;
               CenterOfMassYBeamNew = (CenterOfMassYBeam*MassBeam + (Length - ExtraBodyDown.CoM)*ExtraBodyDown.Mass) / (MassBeam + ExtraBodyDown.Mass);
               CenterOfMassXBeamNew = (CenterOfMassXBeam*MassBeam + ExtraBodyDown.CoMx*ExtraBodyDown.Mass) / (MassBeam + ExtraBodyDown.Mass);
               MassInertiaBeamNew   =   MassInertiaBeam + abs(CenterOfMassYBeamNew - CenterOfMassYBeam)^2 * MassBeam +...
                                        ExtraBodyDown.Inertia + abs(CenterOfMassYBeamNew - (Length - ExtraBodyDown.CoM))^2 * ExtraBodyDown.Mass;
               
                MassBeam            = MassBeamNew;
                CenterOfMassYBeam   = CenterOfMassYBeamNew;
                CenterOfMassXBeam   = CenterOfMassXBeamNew;
                MassInertiaBeam     = MassInertiaBeamNew;
           end
        end
        
        % Assign beam characteristics
        Beam.CrossSection       = CrossSection;
        Beam.Material           = Material;
        
        Beam.LengthLink         = LengthLink;
        Beam.MassLink           = MassLink;                                                       	% [kg/m]
        Beam.MassInertiaLink    = MassInertiaLink;                                                  % [kg*m^2]
        Beam.CenterOfMassYLink 	= CenterOfMassYLink;                                                % [m]
        Beam.CenterOfMassXLink	= CenterOfMassXLink;                                                % [m]
        
        Beam.Length             = Length;                                                       	% [m]
        Beam.Mass               = MassBeam;                                                       	% [kg/m]
        Beam.MassInertia        = MassInertiaBeam;                                                  % [kg*m^2]
        Beam.CenterOfMassY   	= CenterOfMassYBeam;                                                % [m]
        Beam.CenterOfMassX  	= CenterOfMassXBeam;                                                % [m]
        
        Beam.LoadBuckling       = LoadBuckling;                                                     % [N]
        Beam.AspectRatio        = AspectRatio;
        
    case {'Cylindrical_Automatic'}
        % Assign beam characteristics
        CrossSection.rOut    = aspectRatio * Length;                                                % [m]
        CrossSection.Area    = pi * CrossSection.rOut^2;                                            % [m^2]
        CrossSection.ILeast  = pi * CrossSection.rOut^4 / 4;                                    	% [m^2]
        
        Beam.CrossSection  	= CrossSection;
        Beam.Material       = Material;
        Beam.Length        	= Length;                                                             	% [m]
        Beam.Mass         	= CrossSection.Area * Material.Density * Length;                        % [kg/m]
        Beam.MassInertia   	= Beam.Mass * Length^2 / 12;                                          	% [kg*m^2]
        Beam.CenterOfMassY 	= Length/2;                                                          	% [m]
        Beam.CenterOfMassX 	= 0;                                                                 	% [m]
        Beam.LoadBuckling  	= pi^2 * Material.YoungModulus * CrossSection.ILeast / Length^2;        % [N]
        Beam.AspectRatio    = aspectRatio;
        
end

end

function [BeamFemoral, BeamTibial] = updateBeams(BeamFemoral, BeamTibial, ConstructionParameters, varargin)
%% updateBeams 
% Description:  This function takes as inputs the initial femoral and tibial beam. Uses the information contained in
%               the construction parameters to generate extra calculations related to the aspect ratio that satifies the
%               safety to buckling factor. In case of automatic cross-section this function is working recursively.
% 
% Inputs:       Beam:                   struct that contains the information related to a beam of a specific cross-section, material, and length. As fields you can find 
%                                       1) A cross section structure. (CrossSection)
%                                       2) A material structure. (Material)
%                                       3) The beams lenght, mass, mass moment of inertia, the center of mass in x and y direction, 
%                                       critical buckling load and aspect ratio. (Length, Mass, MassInertia, CenterOfMassY, CenterOfMassX,
%                                       LoadBuckling, AspectRatio)
%                                       The suffix "femoral" or "tibial" refers to the corresponding link
%
%               ConstructionParameters:	struct that contains important for the construction base calculation parameters. Those parameters are
%                                       setted in the form of fields. As field you can find.
%                                       1) The total length of the robot (Lall).
%                                       2) The femoral to total length ratio (LFFactor).
%                                       3) The hip to total mass ratio (mHFactor).
%                                       4) The safety to buckling factor for the femoral link
%                                   	5) The safety to buckling factor for the tibial link
%
% Outputs:   Beam:                      struct that contains the information related to a beam of a specific cross-section, material, and length. As fields you can find 
%                                       1) A cross section structure. (CrossSection)
%                                       2) A material structure. (Material)
%                                       3) The beams lenght, mass, mass moment of inertia, the center of mass in x and y direction, 
%                                       critical buckling load and aspect ratio. (Length, Mass, MassInertia, CenterOfMassY, CenterOfMassX,
%                                       LoadBuckling, AspectRatio)
%                                       The suffix "femoral" or "tibial" refers to the corresponding link   
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Parameters
p = inputParser;
p.addParameter('errorTolerance', 1e-15);    % Aspect ration error tolerance
p.addParameter('g', 9.807);                 % Acceleration of gravity [m/s^2]

p.parse(varargin{:})
errorTolerance  = p.Results.errorTolerance;
g               = p.Results.g;

% Load construction parameters
sFFemoral           = ConstructionParameters.sFFemoral;
sFTibial            = ConstructionParameters.sFTibial;
mHFactor            = ConstructionParameters.mHFactor;

% Calculate resulting masses
mLeg                = BeamFemoral.Mass + BeamTibial.Mass;   % [kg]
mLegFactor          = (1 - mHFactor) / 2;
Mall                = mLeg / mLegFactor;                    % [kg]
mH                  = Mall * mHFactor;                      % [kg]

% Calculate resulting loadings
loadHip             = mH * g;                               % [N]
loadFemoral         = BeamFemoral.Mass * g;                 % [N]
loadTibial          = BeamTibial.Mass * g;                  % [N]

% In case that cross section is calculated automatically, update cross-section characteristics in order to avoid buckling
switch BeamFemoral.CrossSection.Name
    case {'Cylindrical_Automatic'}
        % Loading of the femoral beam due to the hip weigth (The safety factor is contained into the loading)
        loadBucklingFemoral     = loadHip/2 * sFFemoral;    % [N]
        
        % Calculate the outer radius in order the beam to satisfy the the buckling limit
        rOutFemoral             = (4 * loadBucklingFemoral * BeamFemoral.Length^2 / pi^3 / BeamFemoral.Material.YoungModulus)^(1/4); 	% [m]
        
        % Extract the aspect ratio of the beam
        aspectRatioFemoral      = rOutFemoral/BeamFemoral.Length;
        
    otherwise
        % The aspect ratio is already contained in the beam structure
        aspectRatioFemoral      = BeamFemoral.AspectRatio;

end

switch BeamTibial.CrossSection.Name
    case {'Cylindrical_Automatic'}
        % Loading of the tibial beam due to the hip and femoral beam weigth (The safety factor is contained into the loading)
        loadBucklingTibial      = (loadHip/2 + loadFemoral) * sFTibial;     % [N]
        
        % Calculate the outer radius in order the beam to satisfy the the buckling limit
        rOutTibial          	= (4 * loadBucklingTibial * BeamTibial.Length^2 / pi^3 / BeamTibial.Material.YoungModulus)^(1/4);       % [m]
        
        % Extract the aspect ratio of the beam
        aspectRatioTibial       = rOutTibial/BeamTibial.Length;
        
    otherwise
        aspectRatioTibial       = BeamTibial.AspectRatio;
        
end

% Compare the initial aspect ratio to the calculated (in order to avoid buckling)
errorTibial     = abs( aspectRatioTibial - BeamTibial.AspectRatio );
errorFemoral    = abs( aspectRatioFemoral - BeamFemoral.AspectRatio );

% In case that the initial and the calculated aspect ratio "Calculation" section of the main function is called again
if any([errorTibial, errorFemoral] > errorTolerance)
    %% Calculations 
    % Generate beam structures
    [BeamFemoral, ~]    = generateBeamStructure(BeamFemoral.CrossSection, BeamFemoral.Material, BeamFemoral.Length, 'aspectRatio', aspectRatioFemoral);
    [BeamTibial, ~]     = generateBeamStructure(BeamTibial.CrossSection, BeamTibial.Material, BeamTibial.Length, 'aspectRatio', aspectRatioTibial);
    
    % Update beams and cross section
    [BeamFemoral, BeamTibial] = updateBeams(BeamFemoral, BeamTibial, ConstructionParameters);
    
end

end
