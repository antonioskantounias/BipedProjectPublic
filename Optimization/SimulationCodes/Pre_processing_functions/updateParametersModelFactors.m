function parametersModelFactors = updateParametersModelFactors(parametersModelFactors)
%% updateParametersModelFactors 
% Description:  This function updates the model parameters that are related to other parameters.
%               For example total non-dimensional length is consider 1. As result, the sum of 
%               femoral and tibial non-dimensional length factor is 1.
% 
% Inputs:       parametersModelFactors: struct that contains all the non dimensional model parameters.
%
% Outputs       parametersModelFactors: struct that contains all the non dimensional model parameters.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Update values
parametersModelFactors.mHFactor     = 1 - 2 * (parametersModelFactors.mTFactor + parametersModelFactors.mFFactor);
parametersModelFactors.LTFactor     = 1 - parametersModelFactors.LFFactor;

end
