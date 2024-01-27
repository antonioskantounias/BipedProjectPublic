function [penaltyCost, ConstraintsDifference] = compareConstraintsWithFactors(Constraints, ModelFactors, penaltyFactor, varargin)
%% compareConstraintsWithFactors 
% Description:  This function compares the model's parameters deviation from the nominal parameters
%               span that the construction constraints structure specifies.
% 
% Inputs:       Constraints:            struct that contains nominal parameters based on the construction characteristics and the deviation span of them that is considered acceptable
%                                       As field you can find.
%                                       1) The nominal parameters that are calculated based on the construction characteristics. (Center)
%                                       2) The model parameters deviation span from the nominal parameters that they are considered acceptable. (Span)
%                                       3) Side data calculated such as total mass, cross section areas, lengths. (Data)
%
%               ModelFactors:           struct with all the undimensional model parameters
%
%               penaltyFactor:          double multiplier factor used at the pelalty calculation 
%
% Outputs:      penaltyCost:            double value of the total penalty due to model's parameters factors deviation from the acceptable factor's span.
%
%               ConstraintsDifference:  struct that contains information related to the deviation of the model's parameter factors from the acceptable factor's span
%                                       according to the Constraints struct. As fields you can find:
%                                       1) The constraint parameter factors names. (constraintNames)
%                                       2) The maximum acceptable value of the parameter factors. (constraintLimitMax)
%                                       3) The minimum acceptable value of the parameter factors. (constraintLimitMin)
%                                       4) The actual parameter factors values. (factorValues)
%                                       5) The actual parameter factors values distance from the maximum factors values. (constraintValuesMax)
%                                       6) The actual parameter factors values distance from the minimum factors values. (constraintValuesMin)
%                                       7) The possitive values of the constraintValuesMax. (constraintValuesMaxOn)
%                                       8) The possitive values of the constraintValuesMin. (constraintValuesMinOn)
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Parameters
ConstructionParametersGainsDefault.lFFactor    = 1;
ConstructionParametersGainsDefault.lTFactor    = 1;
ConstructionParametersGainsDefault.lTxFactor   = 1;
ConstructionParametersGainsDefault.mFFactor    = 1;
ConstructionParametersGainsDefault.mTFactor    = 1;
ConstructionParametersGainsDefault.IFFactor    = 1;
ConstructionParametersGainsDefault.ITFactor    = 1;

p = inputParser;
p.addParameter('constraintsToExclude',{'-'});               % Constraint to be excluded from the calculation of penalty cost
p.addParameter('isDimentional',true);                       % Constraint to be excluded from the calculation of penalty cost
p.addParameter('ConstructionParametersGains',ConstructionParametersGainsDefault)

p.parse(varargin{:})
constraintsToExclude            = p.Results.constraintsToExclude;
isDimentional                 	= p.Results.isDimentional;
ConstructionParametersGains  	= p.Results.ConstructionParametersGains;

%% Extract the difference between the constraints and the existing values
constraintNames             = fieldnames(Constraints.Spans);
numOfConstraints            = length(constraintNames);
constraintLimitsMax         = zeros(numOfConstraints, 1);
constraintLimitsMin         = zeros(numOfConstraints, 1);
factorValues                = zeros(numOfConstraints, 1);
constraintValuesMax         = zeros(numOfConstraints, 1);
constraintValuesMin         = zeros(numOfConstraints, 1);

for iConstraint = 1 : numOfConstraints
    constraintName                      = constraintNames{iConstraint};
    
    if isDimentional
        constraintLimitsMax(iConstraint)    = Constraints.Spans.(constraintName)(2) * Constraints.DimentionalFactor.(constraintName);
        constraintLimitsMin(iConstraint)    = Constraints.Spans.(constraintName)(1) * Constraints.DimentionalFactor.(constraintName);
        factorValues(iConstraint)           = ModelFactors.(constraintName) * Constraints.DimentionalFactor.(constraintName);
        
    else
        constraintLimitsMax(iConstraint)    = Constraints.Spans.(constraintName)(2);
        constraintLimitsMin(iConstraint)    = Constraints.Spans.(constraintName)(1);
        factorValues(iConstraint)           = ModelFactors.(constraintName);
        
    end

    if any( convertCharsToStrings(constraintName) == convertCharsToStrings(constraintsToExclude) )
        continue
        
    else
        constraintValuesMax(iConstraint)    = (factorValues(iConstraint) - constraintLimitsMax(iConstraint))*ConstructionParametersGains.(constraintName);
        constraintValuesMin(iConstraint)   	= constraintLimitsMin(iConstraint) - factorValues(iConstraint)*ConstructionParametersGains.(constraintName);
        
    end
    
end

ConstraintsDifference.constraintNames      	= constraintNames;
ConstraintsDifference.isDimentional         = isDimentional;
ConstraintsDifference.constraintLimitsMax   = constraintLimitsMax;
ConstraintsDifference.constraintLimitsMin   = constraintLimitsMin;
ConstraintsDifference.factorValues          = factorValues;
ConstraintsDifference.constraintValuesMax   = constraintValuesMax;
ConstraintsDifference.constraintValuesMin   = constraintValuesMin;

ConstraintsDifference.constraintValuesMaxOn = constraintValuesMax.*(constraintValuesMax > 0);
ConstraintsDifference.constraintValuesMinOn = constraintValuesMin.*(constraintValuesMin > 0);

%% Calculate penalty
penaltyCost             =   ( ...
                            0 +...
                            sum( constraintValuesMax(constraintValuesMax > 0).^1 ) +...
                            sum( constraintValuesMin(constraintValuesMin > 0).^1 ) ...
                            ) * penaltyFactor;

end