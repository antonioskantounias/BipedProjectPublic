function Samples = calculateJacobianForSamples(samplesPath, JacobianCalculationOptions)
% Calculate jacobian matrix for each sample
SamplesFromPath = load(samplesPath);
Samples = SamplesFromPath.Samples;

% Load jacobian calculation options
perturbation                                    = JacobianCalculationOptions.perturbation;
sectionPlane                                    = JacobianCalculationOptions.sectionPlane;
stepsPerSimulation                              = JacobianCalculationOptions.stepsPerSimulation ;
unconstrainedVariablesToExclude                 = JacobianCalculationOptions.unconstrainedVariablesToExclude;
displayJacobianInfo                             = JacobianCalculationOptions.displayJacobianInfo;

numOfSamples = length(Samples);
for iSample = 1 : numOfSamples
    % Calculate jacobian for each sample
    conditions              = Samples(iSample).fixedPointConditions;
    simulationParameters    = Samples(iSample).simulationParameters;
    jacobian                = generateJacobianMatrix(conditions, perturbation, simulationParameters,...
                                                        'sectionPlane', sectionPlane,...
                                                       	'stepsPerSimulation', stepsPerSimulation,...
                                                        'unconstrainedVariablesToExclude', unconstrainedVariablesToExclude,...
                                                        'displayJacobianInfo', displayJacobianInfo);
   maxEig                       = max(jacobian.eigenValuesNorm);
   
   % Assign results to samples structure
   Samples(iSample).jacobian    = jacobian;
   Samples(iSample).maxEig      = maxEig;
   save(samplesPath, 'Samples');
                                                    
end

end