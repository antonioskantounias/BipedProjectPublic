%% Generate data for DNN
clear
pathSamples = 'C:\Projects\BipedProject\Optimization\SimulationCodes\Investigations\LatinHypercubeSample\LF_lF_lT_mF_mT_IF_IT_20samples.mat';
pathSamplesValidation = 'C:\Projects\BipedProject\Optimization\SimulationCodes\Investigations\LatinHypercubeSample\LF_lF_lT_mF_mT_IF_IT_20samples_Validation.mat';
[folderSamples, fileSamples, ~] = fileparts(pathSamples);

load(pathSamples)
load(pathSamplesValidation)

numOfSamples = length(Samples);
numOfSamplesValidation = length(SamplesValidation);

numOfModelFactors = length(Samples(1).modelFactorNames);

%% Generate DNN input and input unit data
inputValuesUnit = zeros(numOfSamples, numOfModelFactors);
inputValues = zeros(numOfSamples, numOfModelFactors);
for iSample = 1 : numOfSamples
    inputValuesUnit(iSample, :)     = [Samples(iSample).modelFactorValuesUnit];
    inputValues(iSample, :)     = [Samples(iSample).modelFactorValues];
end
inputValuesMax = transpose( [Samples(1).modelFactorSpans(:,2)] );
inputValuesMin = transpose( [Samples(1).modelFactorSpans(:,1)] );

fileInputUnit = [fileSamples, filesep,'inputValuesUnit'];
pathInputUnit = [folderSamples, filesep, fileInputUnit, '.dat'];
writematrix(inputValuesUnit, pathInputUnit)

fileInput = [fileSamples, filesep,'inputValues'];
pathInput = [folderSamples, filesep, fileInput, '.dat'];
writematrix(inputValues, pathInput)

fileInputMax = [fileSamples, filesep,'inputValuesMax'];
pathInput = [folderSamples, filesep, fileInputMax, '.dat'];
writematrix(inputValuesMax, pathInput)

fileInputMin = [fileSamples, filesep,'inputValuesMin'];
pathInput = [folderSamples, filesep, fileInputMin, '.dat'];
writematrix(inputValuesMin, pathInput)

%% Generate DNN output data
outputValues = zeros(numOfSamples, 9);
for iSample = 1 : numOfSamples
    outputValues(iSample, 1)        = [Samples(iSample).maxEig];
    outputValues(iSample, 2:5)      = [Samples(iSample).fixedPointConditions.q];
    outputValues(iSample, 6:9)      = [Samples(iSample).fixedPointConditions.qd];
end

fileOutput = [fileSamples, filesep,'outputValues'];
pathOutput = [folderSamples, filesep, fileOutput, '.dat'];
writematrix(outputValues, pathOutput)

%% Generate DNN output unit data
outputValuesMax                 = max(outputValues);
outputValuesMin                 = min(outputValues);
outputValuesSpan                = outputValuesMax - outputValuesMin;
outputValuesMaxExtended         = outputValuesMax + outputValuesSpan*0.15;
outputValuesMinExtended         = outputValuesMin - outputValuesSpan*0.15;

outputValuesUnit = zeros(numOfSamples, 9);
for iSample = 1 : numOfSamples 
    outputValuesUnit(iSample, :) = (outputValues(iSample, :) - outputValuesMinExtended) ./ (outputValuesMaxExtended - outputValuesMinExtended);
end

fileOutputUnit = [fileSamples, filesep,'outputValuesUnit'];
pathOutputUnit = [folderSamples, filesep, fileOutputUnit, '.dat'];
writematrix(outputValuesUnit, pathOutputUnit)

fileOutputMax = [fileSamples, filesep,'outputValuesMaxExtended'];
pathOutputMax = [folderSamples, filesep, fileOutputMax, '.dat'];
writematrix(outputValuesMaxExtended, pathOutputMax)

fileOutputMin = [fileSamples, filesep,'outputValuesMinExtended'];
pathOutputMin = [folderSamples, filesep, fileOutputMin, '.dat'];
writematrix(outputValuesMinExtended, pathOutputMin)

%% Generate validation input data
inputValuesUnitValidation   = zeros(numOfSamplesValidation, numOfModelFactors);
inputValuesValidation       = zeros(numOfSamplesValidation, numOfModelFactors);
for iSample = 1 : numOfSamplesValidation
    inputValuesUnitValidation(iSample, :)     = [Samples(iSample).modelFactorValuesUnit];
    inputValuesValidation(iSample, :)     = [Samples(iSample).modelFactorValues];
end

fileInputUnit = [fileSamples, filesep,'inputValuesUnitValidation'];
pathInputUnit = [folderSamples, filesep, fileInputUnit, '.dat'];
writematrix(inputValuesUnitValidation, pathInputUnit)

fileInputValidation = [fileSamples, filesep,'inputValuesValidation'];
pathInputValidation = [folderSamples, filesep, fileInputValidation, '.dat'];
writematrix(inputValuesValidation, pathInputValidation)


%% Generate validation output data
outputValuesValidation = zeros(numOfSamplesValidation, 9);
for iSample = 1 : numOfSamplesValidation
    outputValuesValidation(iSample, 1)        = [SamplesValidation(iSample).maxEig];
    outputValuesValidation(iSample, 2:5)      = [SamplesValidation(iSample).fixedPointConditions.q];
    outputValuesValidation(iSample, 6:9)      = [SamplesValidation(iSample).fixedPointConditions.qd];
end

fileOutputValidation = [fileSamples, filesep,'outputValuesValidation'];
pathOutputValidation = [folderSamples, filesep, fileOutputValidation, '.dat'];
writematrix(outputValuesValidation, pathOutputValidation)

%% Generate validation output unit data
outputValuesUnitValidation = zeros(numOfSamplesValidation, 9);
for iSample = 1 : numOfSamplesValidation 
    outputValuesUnitValidation(iSample, :) = (outputValuesValidation(iSample, :) - outputValuesMinExtended) ./ (outputValuesMaxExtended - outputValuesMinExtended);
end

fileOutputUnitValidation = [fileSamples, filesep,'outputValuesUnitValidation'];
pathOutputUnitValidation = [folderSamples, filesep, fileOutputUnitValidation, '.dat'];
writematrix(outputValuesUnitValidation, pathOutputUnitValidation)


