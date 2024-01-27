function [Constraints, RobotLegs] = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionCharacteristics, varargin)
%% generateConstraintsBasedOnActualModel 
% Description:  This function calculates the nominal parameters based on the construction characteristics
%               and the deviation span of them that is considered acceptable
%
% Inputs:       materialNameFemoral: 	char array that indicates the material name of a link. From the material name the usefull material
%                                       characteristics can be extracted. The 'Femoral' extension specifies that the current material is applied to the
%                                       femoral link
%
%               materialNameTibial: 	char array that indicates the material name of a link. From the material name the usefull material
%                                       characteristics can be extracted. The 'Tibial' extension specifies that the current material is applied to the
%                                       tibial link
%
%               crossSectionDataFemoral:struct that contains the main data that are related to the cross-section. The standard field of
%                                       this struct is the name of the cross-section (crossSectionName). The 'Femoral' extension specifies that the current
%                                       crossection name is applied on the femoral link
%
%               crossSectionDataTibial: struct that contains the main data that are related to the cross-section. The standard field of
%                                       this struct is the name of the cross-section (crossSectionName). The 'Tibial' extension specifies that the current
%                                       crossection name is applied on the tibial link
%
%
%               ConstructionParameters: struct that contains important for the construction base calculation parameters. Those parameters are
%                                       setted in the form of fields. As field you can find.
%                                       1) The total length of the robot (Lall).
%                                       2) The femoral to total length ratio (LFFactor).
%                                       3) The hip to total mass ratio (mHFactor).
%                                       4) The safety to buckling factor for the femoral link
%                                       5) The safety to buckling factor for the tibial link
%
% Outputs:      Constraints:          	struct that contains the resulting nominal parameters based on the construction characteristics and the span that is considered acceptable
%                                       As field you can find.
%                                       1) The nominal parameters that are calculated through the construction evaluation (Center).
%                                       2) The deviation span from the nominal parameters that the parameters are considered acceptable (Span).
%                                       3) Side data calculated such as total mass, cross section areas, lengths (Data).
%
%               RobotLegs:              struct that contains for tow beam structures, one for femoral beam and one for tibial beam. Each beam contains
%                                       1) A cross section structure (CrossSection)
%                                       2) A material structure (Material)
%                                       3) The beams lenght, mass, mass moment of inertia, the center of mass in x and y direction, 
%                                       critical buckling load and aspect ratio. (Length, Mass, MassInertia, CenterOfMassY, CenterOfMassX,
%                                       LoadBuckling, AspectRatio)
%
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Parameters
p = inputParser;
p.addParameter('minConstraintSpan',[-0.0005, 0.0005]);  % Minimum deviation from the constraint nominal value

p.parse(varargin{:})
minConstraintSpan       = p.Results.minConstraintSpan;

%% Extract construction data
ConstraintDeviation    	= ConstructionCharacteristics.ConstraintDeviation;
ConstructionParameters  = ConstructionCharacteristics.ConstructionParameters; % Percentage of deviation from the nominal parameters value
Lall                    = ConstructionParameters.Lall;
LFFactor                = ConstructionParameters.LFFactor;
mHFactor                = ConstructionParameters.mHFactor;

%% Generate femoral and tibial beams
% Generate the material structures
MaterialFemoral    	= generateMaterialStructure(materialNameFemoral);
MaterialTibial   	= generateMaterialStructure(materialNameTibial);

% Calculate foot geometrical relations
LengthFemoral       = Lall * LFFactor;                      % [m]
LTFactor            = 1 - LFFactor;
LengthTibial        = Lall * LTFactor;                      % [m]

CrossSectionFemoral = generateCrossSectionStructure(crossSectionDataFemoral, 'alias', 'Femoral');
CrossSectionTibial  = generateCrossSectionStructure(crossSectionDataTibial,'alias','Tibial');

RobotLegs           = generateRobotLegsStructure(CrossSectionFemoral, CrossSectionTibial, LengthFemoral, LengthTibial, MaterialFemoral, MaterialTibial, ConstructionCharacteristics);

BeamFemoral         = RobotLegs.BeamFemoral;
BeamTibial          = RobotLegs.BeamTibial;

%% Calculate parameter factors
% Calculate length factors
CoMFemoral          = BeamFemoral.CenterOfMassY;
CoMTibial           = BeamTibial.CenterOfMassY;
CoMxFemoral         = BeamFemoral.CenterOfMassX;
CoMxTibial          = BeamTibial.CenterOfMassX;

lFFactor            = BeamFemoral.CenterOfMassY / LengthFemoral;
lTFactor            = BeamTibial.CenterOfMassY / LengthTibial;
lTxFactor           = BeamTibial.CenterOfMassX / LengthTibial;

% Calculate resulting mass factors
mLeg                = BeamFemoral.Mass + BeamTibial.Mass;   % [kg]
mLegFactor          = (1 - mHFactor) / 2;
Mall                = mLeg / mLegFactor;                    % [kg]
mH                  = Mall*mHFactor;                        % [kg]

mFFactor            = BeamFemoral.Mass / Mall;      
mTFactor            = BeamTibial.Mass / Mall;

% Calculate resulting inertia factors
IF                  = BeamFemoral.MassInertia;              % [kg*m^2]
IT                  = BeamTibial.MassInertia;               % [kg*m^2]

IFFactor            = IF / BeamFemoral.Mass / LengthFemoral^2;
ITFactor            = IT / BeamTibial.Mass / LengthTibial^2;

%% Generate constraints
Constraints.Names = {   'lFFactor';
                        'lTFactor';
                        'lTxFactor';
                        'mFFactor';
                        'mTFactor';
                        'IFFactor';
                        'ITFactor'};

% Constraints span
Constraints.Spans.lFFactor    = lFFactor + [-lFFactor, lFFactor]*ConstraintDeviation.lFFactor + minConstraintSpan;
Constraints.Spans.lTFactor    = lTFactor + [-lTFactor, lTFactor]*ConstraintDeviation.lTFactor + minConstraintSpan;
Constraints.Spans.lTxFactor   = lTxFactor + [-lTxFactor, lTxFactor]*ConstraintDeviation.lTxFactor + minConstraintSpan;

Constraints.Spans.mFFactor    = mFFactor + [-mFFactor, mFFactor]*ConstraintDeviation.mFFactor + minConstraintSpan;
Constraints.Spans.mTFactor    = mTFactor + [-mTFactor, mTFactor]*ConstraintDeviation.mTFactor + minConstraintSpan;

Constraints.Spans.IFFactor    = IFFactor + [-IFFactor, IFFactor]*ConstraintDeviation.IFFactor + minConstraintSpan;
Constraints.Spans.ITFactor    = ITFactor + [-ITFactor, ITFactor]*ConstraintDeviation.ITFactor + minConstraintSpan;

% Constraints dimentional factor
Constraints.DimentionalFactor.lFFactor = LengthFemoral;
Constraints.DimentionalFactor.lTFactor = LengthTibial;
Constraints.DimentionalFactor.lTxFactor = LengthTibial;

Constraints.DimentionalFactor.mFFactor = Mall;
Constraints.DimentionalFactor.mTFactor = Mall;

Constraints.DimentionalFactor.IFFactor = BeamFemoral.Mass * LengthFemoral^2;
Constraints.DimentionalFactor.ITFactor = BeamTibial.Mass * LengthTibial^2;

% Center of constraints
Constraints.Center.lFFactor     = lFFactor;
Constraints.Center.lTFactor     = lTFactor;
Constraints.Center.lTxFactor    = lTxFactor;

Constraints.Center.mFFactor     =  mFFactor;
Constraints.Center.mTFactor     =  mTFactor;

Constraints.Center.IFFactor     =  IFFactor;
Constraints.Center.ITFactor     =  ITFactor;

% Other data for model validation
Constraints.Data.Mall        	= Mall;
Constraints.Data.IF             = IF;
Constraints.Data.IT             = IT;
Constraints.Data.mF             = BeamFemoral.Mass;
Constraints.Data.mT             = BeamTibial.Mass;
Constraints.Data.mH             = mH;
Constraints.Data.AreaF        	= BeamFemoral.CrossSection.Area;
Constraints.Data.AreaT        	= BeamTibial.CrossSection.Area;
Constraints.Data.LengthFemoral	= LengthFemoral;
Constraints.Data.CoMFemoral     = CoMFemoral;
Constraints.Data.CoMTibial    	= CoMTibial;
Constraints.Data.CoMxFemoral    = CoMxFemoral;
Constraints.Data.CoMxTibial    	= CoMxTibial;
Constraints.Data.LengthTibial 	= LengthTibial;

end
