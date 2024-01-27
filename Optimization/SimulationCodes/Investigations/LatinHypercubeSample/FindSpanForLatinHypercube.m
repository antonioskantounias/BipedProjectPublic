%% Workspace generation
% Generate workspace
clear all
GenerateWorkSpace

% Jacobian options
perturbation                = 1e-4;
max_iter                    = 20;
tol                         = 1e-9;
displayConvergenceProgress  = true;
progressRateMinimum         = 0.4;
maximumNoProgressSteps      = 3;

% Sampling options
investigationAlias  = '23_06_17_samples';
[investigationFolder, ~, ~] = fileparts(which('FindSpanForLatinHypercube'));
savepath            = [investigationFolder, filesep, investigationAlias];

modelFactorNames        = {  'LFFactor'
'lFFactor'
'lTFactor'
'mFFactor'
'mTFactor'
'IFFactor'
'ITFactor'};

modelFactorInitials = [0.256890385134858
0.204763881324034
0.182097958218405
0.0337900536379619
0.0205165420195680
0.0244730555040949
0.0533724287012348];
                    
modelFactorSpans    =  [0.8, 1.2;
                        0.8, 1.2;
                        0.8, 1.2;
                        0.8, 1.2;
                        0.8, 1.2;
                        0.8, 1.2;
                        0.8, 1.2].*modelFactorInitials;

modelFactorCenters  = transpose( ( modelFactorInitials - modelFactorSpans(:,1) ) ./ ( modelFactorSpans(:,2)- modelFactorSpans(:,1) ) );                  
                    
numOfSamples        = 100;

numOfModelFactors   = length(modelFactorNames);

%% Generate latin hypercube samples
rng default
samplesUnitNS         = lhsdesign(numOfSamples, numOfModelFactors, 'smooth', 'off');

% Sort from the smaller to the biger
[~,samplesUnitIndexes] = sort(sum( (samplesUnitNS - modelFactorCenters).^2 , 2));
samplesUnit            = samplesUnitNS(samplesUnitIndexes,:);
samplesDistances       = sum((samplesUnit - modelFactorCenters).^2, 2);

%% Generate edges
nodeVector          = 1:numOfSamples;
edgesCombinations   = nchoosek(nodeVector,2);

numOfEdgeCombinations   = size(edgesCombinations,1);
weightGraph             = zeros(numOfSamples, numOfSamples);

%% Generate weight graph
for iEdgeCombination = 1 : numOfEdgeCombinations
    i = edgesCombinations(iEdgeCombination, 1);
    j = edgesCombinations(iEdgeCombination, 2);
    
    % Calcualate weight graph
 	weightGraph(i,j) = norm( samplesUnit(i,:) - samplesUnit(j,:) );
    weightGraph(j,i) = weightGraph(i,j);

end

%% Generate minimum spaning tree 
spanningTree = prim_mst(weightGraph);
numOfTreeSpans = length(spanningTree);

%% Calculate fixed point condition for all the samples

% Samples = struct;
% Samples = struct();
% iTreeSpanInitial = 0;
% Samples(1).modelFactorNames = modelFactorNames;
% Samples(1).modelFactorSpans = modelFactorSpans;

load('C:\Projects\BipedProject\Optimization\SimulationCodes\Investigations\LatinHypercubeSample\23_06_17_samples.mat')
iTreeSpanInitial = 39;
% nos = 0; for i=1:89; if isstruct(Samples(i).fixedPointConditions); nos = nos + 1; end; end; iTreeSpanInitial = nos;

% Calculate initial condition for the first element of spanning tree
for iTreeSpan = iTreeSpanInitial : numOfTreeSpans
    tic
    if iTreeSpan == 0
        sampleIndex                 = spanningTree(1,1);
        [simulationParameters, modelFactorValuesUnit, modelFactorValues]        = updateSimulationModelParameters(simulationParameters, parametersModelFactors, samplesUnit, sampleIndex, modelFactorSpans, modelFactorNames);
        initialConditionsSample     = initialConditions;
    else
        sampleIndex                 = spanningTree(iTreeSpan,2);
        sampleICIndex               = spanningTree(iTreeSpan,1);
        [simulationParameters, modelFactorValuesUnit, modelFactorValues]        = updateSimulationModelParameters(simulationParameters, parametersModelFactors, samplesUnit, sampleIndex, modelFactorSpans, modelFactorNames);
        initialConditionsSample     = Samples(sampleICIndex).fixedPointConditions;
    end
    
    [fixedPointConditions, jacobian, resemblanceMetricsFunction, resemblanceMetricsSolution, isStateConverged]    = calculateFixedPointConditionsWithJacobian(initialConditionsSample, simulationParameters, ...
        'perturbation', perturbation, ...
        'max_iter', max_iter, ...
        'tol', tol, ...
        'displayConvergenceProgress', displayConvergenceProgress, ...
        'progressRateMinimum', progressRateMinimum, ...
        'maximumNoProgressSteps', maximumNoProgressSteps,...
        'sectionPlane',sectionPlane);
    
    Samples(sampleIndex).fixedPointConditions           = fixedPointConditions;
    Samples(sampleIndex).jacobian                       = jacobian;
    Samples(sampleIndex).resemblanceMetricsFunction   	= resemblanceMetricsFunction;
    Samples(sampleIndex).resemblanceMetricsSolution   	= resemblanceMetricsSolution;
    Samples(sampleIndex).modelFactorValuesUnit          = modelFactorValuesUnit;
    Samples(sampleIndex).modelFactorValues              = modelFactorValues;
    Samples(sampleIndex).simulationParameters           = simulationParameters;
    Samples(sampleIndex).maxEig                      	= jacobian.eigenValueMax;
    Samples(sampleIndex).maxReturnMap               	= resemblanceMetricsFunction.DifferenceAbsolute.Maximum;

    Samples(1).iTreeSpan                                = iTreeSpan;
    save(savepath, 'Samples')
    toc
end

%% Generate random test samples
SamplesValidation = struct;
SamplesValidation = struct();
SamplesValidation(1).modelFactorNames = modelFactorNames;
SamplesValidation(1).modelFactorSpans = modelFactorSpans;
% load('C:\Projects\BipedProject\Optimization\SimulationCodes\Investigations\LatinHypercubeSample\LF_lF_lT_mF_mT_IF_IT_20samples_Validation.mat')

rng default
numOfRandomSamples = 3;
samplesRandom = rand(numOfRandomSamples, numOfModelFactors);

for iRandomSample = 1 : numOfRandomSamples
    sampleRandom = samplesRandom(iRandomSample,:);
    samplesDistance2Random          = sum((samplesUnit - sampleRandom).^2, 2);
    [~, sampleAuxilaryIndex]        = min(samplesDistance2Random);
    
    [simulationParameters, modelFactorValuesUnit, modelFactorValues]        = updateSimulationModelParameters(simulationParameters, parametersModelFactors, samplesRandom, iRandomSample, modelFactorSpans, modelFactorNames);
    
    initialConditionsSample         = Samples(sampleAuxilaryIndex).fixedPointConditions;
    
    [fixedPointConditions, jacobian, resemblanceMetricsFunction, resemblanceMetricsSolution, isStateConverged]    = calculateFixedPointConditionsWithJacobian(initialConditionsSample, simulationParameters, ...
        'perturbation', perturbation, ...
        'max_iter', max_iter, ...
        'tol', tol, ...
        'displayConvergenceProgress', displayConvergenceProgress, ...
        'progressRateMinimum', progressRateMinimum, ...
        'maximumNoProgressSteps', maximumNoProgressSteps,...
        'sectionPlane',sectionPlane);
    
    SamplesValidation(iRandomSample).fixedPointConditions           = fixedPointConditions;
    SamplesValidation(iRandomSample).jacobian                       = jacobian;
    SamplesValidation(iRandomSample).resemblanceMetricsFunction   	= resemblanceMetricsFunction;
    SamplesValidation(iRandomSample).resemblanceMetricsSolution   	= resemblanceMetricsSolution;
    SamplesValidation(iRandomSample).modelFactorValuesUnit          = modelFactorValuesUnit;
    SamplesValidation(iRandomSample).modelFactorValues              = modelFactorValues;
    SamplesValidation(iRandomSample).simulationParameters           = simulationParameters;
    SamplesValidation(iRandomSample).maxEig                       	= jacobian.eigenValueMax;
    SamplesValidation(iRandomSample).maxReturnMap                   = resemblanceMetricsFunction.DifferenceAbsolute.Maximum;
    
    save([savepath,'_Validation'], 'SamplesValidation')
    
end

%% Extra functions
% Update simulation model parameters based on latin hypercube sampling
function [simulationParameters, modelFactorValuesUnit, modelFactorValues] = updateSimulationModelParameters(simulationParameters, parametersModelFactors, samplesUnit, sampleIndex, modelFactorSpans, modelFactorNames)

        modelFactorValuesUnit  	= samplesUnit(sampleIndex, :);
        modelFactorValues       = zeros(size(modelFactorValuesUnit));
        numOfModelFactors       = length(modelFactorValuesUnit);
        
        for iModelFactor = 1 : numOfModelFactors
            modelFactorName                             = modelFactorNames{iModelFactor};
            modelFactorValue                            = modelFactorSpans(iModelFactor, 1) + modelFactorValuesUnit(iModelFactor) * ( modelFactorSpans(iModelFactor, 2) - modelFactorSpans(iModelFactor, 1) ); 
            modelFactorValues(iModelFactor)             = modelFactorValue;
            parametersModelFactors.(modelFactorName)    = modelFactorValue;
            
            parametersModelFactors                      = updateParametersModelFactors(parametersModelFactors);
            parametersModel                             = generateParametersModel(parametersModelFactors);
            simulationParameters.Model                  = parametersModel;
        end

end
