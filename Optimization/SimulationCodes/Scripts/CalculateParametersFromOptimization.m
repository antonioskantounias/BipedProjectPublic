%% Generate parameters for cad model
% From iteration results specify the dimentional values and the calculate the cad parameters that correspond to the specific cad
load('C:\Projects\BipedProjectV2\Optimization\SimulationCodes\OptimizationResults\Optimization5ConstructionSmall\iterationResults78.mat')

parametersModelFactors = iterationResults(1).parametersModelFactors;
% parametersModelFactors.Mall = iterationResults(1).functionCallDetailsBack.Constraints.Data.Mall;
parametersModelFactors.Mall = 2.736/(1-parametersModelFactors.mFFactor*2-parametersModelFactors.mTFactor*2);
parametersModelFactors.Lall = 0.550;
parametersModelFactors.g = 9.81;
parametersModel = generateParametersModel(parametersModelFactors);
