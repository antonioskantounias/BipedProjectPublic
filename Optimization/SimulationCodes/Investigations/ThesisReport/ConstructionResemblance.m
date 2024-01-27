%%% Cross section definition based on cad model-------------------------------------------------------------------------------------------------------------
crossSectionDataFemoral.crossSectionName                        = 'Rectangular';                    % Cross section type at the femoral link of the byped
crossSectionDataFemoral.bOut                                    = 31.7*1e-3;                        % Outer width dimension [m]
crossSectionDataFemoral.bIn                                     = 21.7*1e-3;                        % Inner width dimension [m]
crossSectionDataFemoral.hOut                                    = 35*1e-3;                          % Outer depth dimension [m]
crossSectionDataFemoral.hIn                                     = 29*1e-3;                          % Inner depth dimension [m]

crossSectionDataTibial.crossSectionName                         = 'Rectangular';                    % Cross section type at the tibial link of the byped
crossSectionDataTibial.bOut                                     = 20*1e-3;                          % Outer width dimension [m]
crossSectionDataTibial.bIn                                      = 17*1e-3;                           % Inner width dimension [m]
crossSectionDataTibial.hOut                                     = 20*1e-3;                          % Outer depth dimension [m]
crossSectionDataTibial.hIn                                      = 17*1e-3;                           % Inner depth dimension [m]

beamFemoralData.OffsetUp                                        = 28*1e-3;                          % Offset of the upper part of the femoral link from the hip axis. (with possitive direction to the across link edge)
beamFemoralData.OffsetDown                                      = 43.5*1e-3;                        % Offset of the lower part of the femoral link from the knee axis. (with possitive direction to the across link edge)
beamFemoralData.OffsetOut                                       = 0*1e-3;

beamFemoralData.ExtraBodyUp(1).Mass                             = 0.471;                            % Extra body mass [kg]
beamFemoralData.ExtraBodyUp(1).CoM                              = 0.0025;                         % Extra body center of mass [m] (Zero is considered the theoretical links upper edge with possitive direction to the across edge) 
beamFemoralData.ExtraBodyUp(1).CoMx                             = 0;                                % Extra body center of mass in x direction [m] (Zero is considered the theoretical links edge with possitive direction the gait's direction) 
beamFemoralData.ExtraBodyUp(1).Inertia                          = 0.00011406;                      % Extra body inertia around it's center of mass [kg*m^2]

beamFemoralData.ExtraBodyDown(1).Mass                           = 0.183;                          % Extra body mass [kg]
beamFemoralData.ExtraBodyDown(1).CoM                            = -(124.59 - 159)*1e-3;            % Extra body center of mass [m] (Zero is considered the theoretical links lower edge with possitive direction to the across edge) 
beamFemoralData.ExtraBodyDown(1).CoMx                           = 0;                                % Extra body center of mass in x direction [m] (Zero is considered the theoretical links edge with possitive direction the gait's direction) 
beamFemoralData.ExtraBodyDown(1).Inertia                        = 0.0000923;                     % Extra body inertia around it's center of mass [kg*m^2]

beamTibialData.OffsetUp                                         = 19*1e-3;                          % Offset of the upper part of the tibial link from the knee axis (with possitive direction to the across link edge)
beamTibialData.OffsetDown                                       = 10.16*1e-3;                        % Offset of the lower part of the tibial link from the foot axis (with possitive direction to the across link edge)
beamTibialData.OffsetOut                                        = 4.5*1e-3;

beamTibialData.ExtraBodyUp(1).Mass                           	= 0.0804;                        % Extra body mass [kg]
beamTibialData.ExtraBodyUp(1).CoM                             	= (212.1-200.1)*1e-3;              	% Extra body center of mass [m] (Zero is considered the theoretical links lower edge with possitive direction to the across edge)  
beamTibialData.ExtraBodyUp(1).CoMx                              = (-3.1 -(-7.9))*1e-3;                                % Extra body center of mass in x direction [m] (Zero is considered the theoretical links edge with possitive direction the gait's direction) 
beamTibialData.ExtraBodyUp(1).Inertia                        	= 0.00003749;                       % Extra body inertia around it's center of mass [kg*m^2]

beamTibialData.ExtraBodyDown(1).Mass                           	= 0.04826;                         % Extra body mass [kg]
beamTibialData.ExtraBodyDown(1).CoM                         	= -(581.0-591.1)*1e-3;           	% Extra body center of mass [m] (Zero is considered the theoretical links upper part 
beamTibialData.ExtraBodyDown(1).CoMx                          	= (20.95 -(-7.9))*1e-3;          	% Extra body center of mass in x direction [m] (Zero is considered the theoretical links edge with possitive direction the gait's direction) 
beamTibialData.ExtraBodyDown(1).Inertia                      	= 0.00003503;                   	% Extra body inertia around it's center of mass [kg*m^2]

%%%---------------------------------------------------------------------------------------------------------------------------------------------------------
materialNameFemoral                                             = 'ABS';                            % Material at the femoral link of the byped
materialNameTibial                                              = 'CarbonFiber';                	% Material of the tibial link of the biped

ConstructionParameters.Lall                                     = 0.550;                         	% Total length of the byped [m]
ConstructionParameters.LFFactor                                 = 0.289298466195288;             	% Femoral to total length factor
ConstructionParameters.mHFactor                               	= 0.9;                              % Hip to total mass factor
ConstructionParameters.sFFemoral                              	= 250;                              % Safety to buckling factor for the femoral link
ConstructionParameters.sFTibial                                 = 150;                              % Safety to buckling factor for the tibial link

%%%----------------------------------------------------------------------------------------------------------------------------------------------------------
ConstructionParametersGains.lFFactor    = 2e2;
ConstructionParametersGains.lTFactor    = 2e3;
ConstructionParametersGains.lTxFactor   = 1;
ConstructionParametersGains.mFFactor    = 0.6;
ConstructionParametersGains.mTFactor    = 0.7;
ConstructionParametersGains.IFFactor    = 1.2e3;
ConstructionParametersGains.ITFactor    = 1.3e2;

ConstructionCharacteristics.materialNameFemoral                 = materialNameFemoral;                      
ConstructionCharacteristics.materialNameTibial                  = materialNameTibial;
ConstructionCharacteristics.crossSectionDataFemoral           	= crossSectionDataFemoral;
ConstructionCharacteristics.crossSectionDataTibial            	= crossSectionDataTibial;
ConstructionCharacteristics.beamFemoralData                     = beamFemoralData;
ConstructionCharacteristics.beamTibialData                      = beamTibialData;
ConstructionCharacteristics.ConstructionParameters            	= ConstructionParameters;
ConstructionCharacteristics.ConstructionParametersGains         = ConstructionParametersGains;

%%%----------------------------------------------------------------------------------------------------------------------------------------------------------
%% Calculate construction penalties
% Load construction characteristics
ConstructionParameters                  = ConstructionCharacteristics.ConstructionParameters;

% Generate constraints related to construction characteristics
[Constraints, RobotLegs]                = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionCharacteristics);
