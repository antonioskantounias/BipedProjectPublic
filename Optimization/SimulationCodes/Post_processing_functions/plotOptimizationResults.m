function OptimizationFigures = plotOptimizationResults(optimizationPath)
%% plotOptimizationResults 
% Description:  This function takes as input the save folder and extracts plot of the the optimization process
%               helpfull for the user. The user obtains inside about the design variables, the cost function
%               the gradients with of the cost function with respect to the design variables.
% 
% Inputs:       optimizationPath:       char that indicates the path of the folder where the optimization results are saved.
%
% Outputs:      OptimizationFigures:    struct that contains all the resulted optimization figure handles.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Find the number of iteration into the optimazation folder
% Calculate the number of variables
load( [optimizationPath, filesep, 'iterationResults1.mat'] )
numOfDesignFactors	= length(iterationResults);
designFactors       = {iterationResults.designFactors};

% Calculate the number of optimization iterations
numOfIterations     = 0;
while isfile([optimizationPath, filesep, 'iterationResults', num2str( numOfIterations + 1 ), '.mat'])
    numOfIterations = numOfIterations + 1;
end

%% Generate plot options
pOpts   = loadPlotOptions;

%% Generate costs plot
% Initial plot data
costMean                    = zeros(1, numOfIterations);
eigenValueMaxCostMean       = zeros(1, numOfIterations);
eigenValueRobustnessCostMean= zeros(1, numOfIterations);
constructionCostMean        = zeros(1, numOfIterations);
meanFootClearanceCostMean   = zeros(1, numOfIterations);
minFootClearanceCostMean    = zeros(1, numOfIterations);
constructionMassCostMean        = zeros(1, numOfIterations);

for iIteration = 1:numOfIterations
    % Load the iteration results data
    load([optimizationPath, filesep, 'iterationResults', num2str( iIteration ), '.mat'])
    
    % Calculate the costs for each iteration
    cost                    = zeros(1, numOfDesignFactors);
    eigenValueMaxCost       = zeros(1, numOfDesignFactors);
    eigenValueRobustnessCost= zeros(1, numOfDesignFactors);
    constructionCost        = zeros(1, numOfDesignFactors);
    meanFootClearanceCost   = zeros(1, numOfDesignFactors);     
    minFootClearanceCost    = zeros(1, numOfDesignFactors);
    constructionMassCost    = zeros(1, numOfDesignFactors);
    
    for iDesignFactor = 1 : numOfDesignFactors
        functionCallDetailsFront                                    = iterationResults(iDesignFactor).functionCallDetailsFront;
        functionCallDetailsBack                                     = iterationResults(iDesignFactor).functionCallDetailsBack;
        
        cost(iDesignFactor)                                         = iterationResults(iDesignFactor).cost;
        eigenValueMaxCost(iDesignFactor)                            = (functionCallDetailsFront.eigenValueMaxCost + functionCallDetailsBack.eigenValueMaxCost)/2;
        eigenValueRobustnessCost(iDesignFactor)                 	= (functionCallDetailsFront.eigenValueRobustnessCost + functionCallDetailsBack.eigenValueRobustnessCost)/2;
        constructionCost(iDesignFactor)                             = (functionCallDetailsFront.constructionCost + functionCallDetailsBack.constructionCost)/2;
        meanFootClearanceCost(iDesignFactor)                        = (functionCallDetailsFront.meanFootClearanceCost + functionCallDetailsBack.meanFootClearanceCost)/2;
        minFootClearanceCost(iDesignFactor)                         = (functionCallDetailsFront.minFootClearanceCost + functionCallDetailsBack.minFootClearanceCost)/2;
        constructionMassCost(iDesignFactor)                         = (functionCallDetailsFront.constructionMassCost + functionCallDetailsBack.constructionMassCost)/2;
        
    end
    
    costMean(iIteration)                    = mean(cost);
    eigenValueMaxCostMean(iIteration)       = mean(eigenValueMaxCost);
    eigenValueRobustnessCostMean(iIteration)= mean(eigenValueRobustnessCost);
    constructionCostMean(iIteration)        = mean(constructionCost);
    meanFootClearanceCostMean(iIteration)   = mean(meanFootClearanceCost);
    minFootClearanceCostMean(iIteration)    = mean(minFootClearanceCost);
    constructionMassCostMean(iIteration)    = mean(constructionMassCost);
    
end

% Generate the plot
figureCost              = pOpts.gFigure('Cost Plot');
figureCost.Visible      = 'on';

axesCost                = pOpts.gAxes(figureCost);
axesCost.XGrid          = 'on';
axesCost.YGrid          = 'on';
axesCost.XMinorGrid     = 'on';
axesCost.YMinorGrid     = 'on';
axesCost.Title.String   = sprintf('Optimization''s cost function values \nvs optimization iteration number');
axesCost.XLabel.String  = 'Iteration';
axesCost.YLabel.String  = 'Cost';

iterationsVec               = 1 : numOfIterations;
pCost                       = pOpts.gLine(axesCost, iterationsVec, costMean);
pEigenValueMaxCost          = pOpts.gLine(axesCost, iterationsVec, eigenValueMaxCostMean);
pEigenValueRobustnessCost  	= pOpts.gLine(axesCost, iterationsVec, eigenValueRobustnessCostMean);
pConstructionCost           = pOpts.gLine(axesCost, iterationsVec, constructionCostMean);
pMeanFootClearanceCost      = pOpts.gLine(axesCost, iterationsVec, meanFootClearanceCostMean);
pMinFootClearanceCost       = pOpts.gLine(axesCost, iterationsVec, minFootClearanceCostMean);
pConstructionMassCost       = pOpts.gLine(axesCost, iterationsVec, constructionMassCostMean);

linecolors                      = pOpts.colormapFunction(7);
pEigenValueMaxCost.Color       	= linecolors(1,:);
pEigenValueRobustnessCost.Color	= linecolors(2,:);
pConstructionCost.Color     	= linecolors(3,:);
pMeanFootClearanceCost.Color  	= linecolors(4,:);
pCost.Color                     = linecolors(5,:);
pMinFootClearanceCost.Color  	= linecolors(6,:);
pConstructionMassCost.Color  	= linecolors(7,:);

lCost                   = legend(axesCost); 
lCost.Location          = 'best';
lCost.String{1}         = 'Total Cost';
lCost.String{2}         = 'Max Eigenvalue Cost';
lCost.String{3}         = 'Mean Max Eigenvalue Cost';
lCost.String{4}         = 'Construction Cost';
lCost.String{5}         = 'Mean Foot Clearance Cost';
lCost.String{6}         = 'Minimum Foot Clearance Cost';
lCost.String{7}         = 'Construction Mass Cost';

% Delete not activated cost functions
load([optimizationPath, filesep, 'OptimizationOptions.mat'])
if ~OptimizationOptions.CostFunctionOptions.evaluateEigenValueMax
    delete(pEigenValueMaxCost)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateEigenValueRobustness
    delete(pEigenValueRobustnessCost)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateConstruction
    delete(pConstructionCost)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateConstructionMass
    delete(pConstructionMassCost)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateMinFootClearance
    delete(pMinFootClearanceCost)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateMeanFootClearance
    delete(pMeanFootClearanceCost)
end

OptimizationFigures.figureCost = figureCost;

%% Generate gradients norm plots
% Initial plot data
gradientNorm                = zeros(1, numOfIterations);
eigenValueMaxGrNorm         = zeros(1, numOfIterations);
eigenValueRobustnessGrNorm 	= zeros(1, numOfIterations);
constructionGrNorm          = zeros(1, numOfIterations);
meanFootClearanceGrNorm     = zeros(1, numOfIterations);
minFootClearanceGrNorm      = zeros(1, numOfIterations);
constructionMassGrNorm      = zeros(1, numOfIterations);

for iIteration = 1:numOfIterations
    % Load the iteration results data
    load([optimizationPath, filesep, 'iterationResults', num2str( iIteration ), '.mat'])
    
    % Calculate the gradients for each iteration
    gradient              	= zeros(1, numOfDesignFactors);
    eigenValueMaxGr         = zeros(1, numOfDesignFactors);
    eigenValueRobustnessGr 	= zeros(1, numOfDesignFactors);
    constructionGr          = zeros(1, numOfDesignFactors);
    meanFootClearanceGr     = zeros(1, numOfDesignFactors);     
    minFootClearanceGr      = zeros(1, numOfDesignFactors);
    constructionMassGr      = zeros(1, numOfDesignFactors);
    
    for iDesignFactor = 1 : numOfDesignFactors
        
        gradient(iDesignFactor)                 = iterationResults(iDesignFactor).gradient;
        eigenValueMaxGr(iDesignFactor)      	= iterationResults(iDesignFactor).eigenValueMaxGr;
        eigenValueRobustnessGr(iDesignFactor) 	= iterationResults(iDesignFactor).eigenValueRobustnessGr;
        constructionGr(iDesignFactor)         	= iterationResults(iDesignFactor).constructionGr;
        meanFootClearanceGr(iDesignFactor)  	= iterationResults(iDesignFactor).meanFootClearanceGr;
        minFootClearanceGr(iDesignFactor)    	= iterationResults(iDesignFactor).minFootClearanceGr;
        constructionMassGr(iDesignFactor)    	= iterationResults(iDesignFactor).constructionMassGr;
        
    end
    
    gradientNorm(iIteration)              	= norm(gradient);
    eigenValueMaxGrNorm(iIteration)         = norm(eigenValueMaxGr);
    eigenValueRobustnessGrNorm(iIteration) 	= norm(eigenValueRobustnessGr);
    constructionGrNorm(iIteration)          = norm(constructionGr);
    meanFootClearanceGrNorm(iIteration)     = norm(meanFootClearanceGr);
    minFootClearanceGrNorm(iIteration)      = norm(minFootClearanceGr);
    constructionMassGrNorm(iIteration)      = norm(constructionMassGr);
    
end

% Generate the plot
figureGradient              = pOpts.gFigure('Gradient Plot');
figureGradient.Visible      = 'on';

axesGradient                = pOpts.gAxes(figureGradient);
axesGradient.XGrid          = 'on';
axesGradient.YGrid          = 'on';
axesGradient.XMinorGrid     = 'on';
axesGradient.YMinorGrid     = 'on';
axesGradient.Title.String   = sprintf('Optimization''s cost function gradients norm \nvs optimization iteration number');
axesGradient.XLabel.String  = 'Iteration';
axesGradient.YLabel.String  = 'Gradient';

iterationsVec                   = 1 : numOfIterations;
pGradient                       = pOpts.gLine(axesGradient, iterationsVec, gradientNorm);
pEigenValueMaxGradient          = pOpts.gLine(axesGradient, iterationsVec, eigenValueMaxGrNorm);
pEigenValueRobustnessGradient 	= pOpts.gLine(axesGradient, iterationsVec, eigenValueRobustnessGrNorm);
pConstructionGradient           = pOpts.gLine(axesGradient, iterationsVec, constructionGrNorm);
pMeanFootClearanceGradient      = pOpts.gLine(axesGradient, iterationsVec, meanFootClearanceGrNorm);
pMinFootClearanceGradient       = pOpts.gLine(axesGradient, iterationsVec, minFootClearanceGrNorm);
pConstructionMassGradient       = pOpts.gLine(axesGradient, iterationsVec, constructionMassGrNorm);

linecolors                        	= pOpts.colormapFunction(7);
pEigenValueMaxGradient.Color       	= linecolors(1,:);
pEigenValueRobustnessGradient.Color	= linecolors(2,:);
pConstructionGradient.Color     	= linecolors(3,:);
pMeanFootClearanceGradient.Color  	= linecolors(4,:);
pGradient.Color                     = linecolors(5,:);
pMinFootClearanceGradient.Color  	= linecolors(6,:);
pConstructionMassGradient.Color  	= linecolors(7,:);

lGradient                   = legend(axesGradient); 
lGradient.Location          = 'best';
lGradient.String{1}         = 'Total Gradient';
lGradient.String{2}         = 'Max Eigenvalue Gradient';
lGradient.String{3}         = 'Mean Max Eigenvalue Gradient';
lGradient.String{4}         = 'Construction Gradient';
lGradient.String{5}         = 'Mean Foot Clearance Gradient';
lGradient.String{6}         = 'Minimum Foot Clearance Gradient';
lGradient.String{7}         = 'Construction mass Gradient';

% Delete not activated cost functions
load([optimizationPath, filesep, 'OptimizationOptions.mat'])
if ~OptimizationOptions.CostFunctionOptions.evaluateEigenValueMax
    delete(pEigenValueMaxGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateEigenValueRobustness
    delete(pEigenValueRobustnessGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateConstruction
    delete(pConstructionGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateConstructionMass
    delete(pConstructionMassGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateMinFootClearance
    delete(pMinFootClearanceGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateMeanFootClearance
    delete(pMeanFootClearanceGradient)
end

OptimizationFigures.figureGradient = figureGradient;

%% Generate gradients mean plots
% Initial plot data
gradientMean                = zeros(1, numOfIterations);
eigenValueMaxGrMean         = zeros(1, numOfIterations);
eigenValueRobustnessGrMean 	= zeros(1, numOfIterations);
constructionGrMean          = zeros(1, numOfIterations);
meanFootClearanceGrMean     = zeros(1, numOfIterations);
minFootClearanceGrMean      = zeros(1, numOfIterations);
constructionMassGrMean      = zeros(1, numOfIterations);

for iIteration = 1:numOfIterations
    % Load the iteration results data
    load([optimizationPath, filesep, 'iterationResults', num2str( iIteration ), '.mat'])
    
    % Calculate the gradients for each iteration
    gradient             	= zeros(1, numOfDesignFactors);
    eigenValueMaxGr         = zeros(1, numOfDesignFactors);
    eigenValueRobustnessGr 	= zeros(1, numOfDesignFactors);
    constructionGr          = zeros(1, numOfDesignFactors);
    meanFootClearanceGr     = zeros(1, numOfDesignFactors);     
    minFootClearanceGr      = zeros(1, numOfDesignFactors);
    constructionMassGr      = zeros(1, numOfDesignFactors);
    
    for iDesignFactor = 1 : numOfDesignFactors
        
        gradient(iDesignFactor)                 = iterationResults(iDesignFactor).gradient;
        eigenValueMaxGr(iDesignFactor)      	= iterationResults(iDesignFactor).eigenValueMaxGr;
        eigenValueRobustnessGr(iDesignFactor)	= iterationResults(iDesignFactor).eigenValueRobustnessGr;
        constructionGr(iDesignFactor)         	= iterationResults(iDesignFactor).constructionGr;
        meanFootClearanceGr(iDesignFactor)  	= iterationResults(iDesignFactor).meanFootClearanceGr;
        minFootClearanceGr(iDesignFactor)    	= iterationResults(iDesignFactor).minFootClearanceGr;
        constructionMassGr(iDesignFactor)    	= iterationResults(iDesignFactor).constructionMassGr;
        
    end
    
    gradientMean(iIteration)                = mean(gradient);
    eigenValueMaxGrMean(iIteration)         = mean(eigenValueMaxGr);
    eigenValueRobustnessGrMean(iIteration) 	= mean(eigenValueRobustnessGr);
    constructionGrMean(iIteration)          = mean(constructionGr);
    meanFootClearanceGrMean(iIteration)     = mean(meanFootClearanceGr);
    minFootClearanceGrMean(iIteration)      = mean(minFootClearanceGr);
    constructionMassGrMean(iIteration)      = mean(constructionMassGr);
    
end

% Generate the plot
figureGradient              = pOpts.gFigure('Gradient Plot');
figureGradient.Visible      = 'on';

axesGradient                = pOpts.gAxes(figureGradient);
axesGradient.XGrid          = 'on';
axesGradient.YGrid          = 'on';
axesGradient.XMinorGrid     = 'on';
axesGradient.YMinorGrid     = 'on';
axesGradient.Title.String   = sprintf('Optimization''s cost function gradients mean \nvs optimization iteration number');
axesGradient.XLabel.String  = 'Iteration';
axesGradient.YLabel.String  = 'Gradient';

iterationsVec                   = 1 : numOfIterations;
pGradient                       = pOpts.gLine(axesGradient, iterationsVec, gradientMean);
pEigenValueMaxGradient          = pOpts.gLine(axesGradient, iterationsVec, eigenValueMaxGrMean);
pEigenValueRobustnessGradient  	= pOpts.gLine(axesGradient, iterationsVec, eigenValueRobustnessGrMean);
pConstructionGradient           = pOpts.gLine(axesGradient, iterationsVec, constructionGrMean);
pMeanFootClearanceGradient      = pOpts.gLine(axesGradient, iterationsVec, meanFootClearanceGrMean);
pMinFootClearanceGradient       = pOpts.gLine(axesGradient, iterationsVec, minFootClearanceGrMean);
pConstructionMassGradient       = pOpts.gLine(axesGradient, iterationsVec, constructionMassGrMean);

linecolors                         	= pOpts.colormapFunction(7);
pEigenValueMaxGradient.Color       	= linecolors(1,:);
pEigenValueRobustnessGradient.Color	= linecolors(2,:);
pConstructionGradient.Color     	= linecolors(3,:);
pMeanFootClearanceGradient.Color  	= linecolors(4,:);
pGradient.Color                     = linecolors(5,:);
pMinFootClearanceGradient.Color  	= linecolors(6,:);
pConstructionMassGradient.Color  	= linecolors(7,:);

lGradient                   = legend(axesGradient); 
lGradient.Location          = 'best';
lGradient.String{1}         = 'Total Gradient';
lGradient.String{2}         = 'Max Eigenvalue Gradient';
lGradient.String{3}         = 'Mean Max Eigenvalue Gradient';
lGradient.String{4}         = 'Construction Gradient';
lGradient.String{5}         = 'Mean Foot Clearance Gradient';
lGradient.String{6}         = 'Minimum Foot Clearance Gradient';
lGradient.String{7}         = 'Construction Mass Gradient';

% Delete not activated cost functions
load([optimizationPath, filesep, 'OptimizationOptions.mat'])
if ~OptimizationOptions.CostFunctionOptions.evaluateEigenValueMax
    delete(pEigenValueMaxGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateEigenValueRobustness
    delete(pEigenValueRobustnessGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateConstruction
    delete(pConstructionGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateConstructionMass
    delete(pConstructionMassGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateMinFootClearance
    delete(pMinFootClearanceGradient)
end
if ~OptimizationOptions.CostFunctionOptions.evaluateMeanFootClearance
    delete(pMeanFootClearanceGradient)
end

OptimizationFigures.figureGradient = figureGradient;

%% Generate design factors plot
% Initial plot data
designFactorValues  = zeros(numOfDesignFactors, numOfIterations);
for iIteration = 1 : numOfIterations
    % Load the iteration results data
    load([optimizationPath, filesep, 'iterationResults', num2str( iIteration ), '.mat'])
    
    for iDesignFactor = 1 : numOfDesignFactors
        designFactorValues(iDesignFactor, iIteration) = iterationResults(iDesignFactor).designFactorsValues;
    end
end

% Generate the plot
figureDesignFactors             = pOpts.gFigure('Design factor Plot');
figureDesignFactors.Visible  	= 'on';

axesDesignFactors               = pOpts.gAxes(figureDesignFactors);
axesDesignFactors.XGrid        	= 'on';
axesDesignFactors.YGrid        	= 'on';
axesDesignFactors.XMinorGrid  	= 'on';
axesDesignFactors.YMinorGrid 	= 'on';
axesDesignFactors.Title.String	= sprintf('Design factor values \nvs optimization iteration number');
axesDesignFactors.XLabel.String	= 'Iteration';
axesDesignFactors.YLabel.String	= 'D.F. Value';

iterationsVec           = 1 : numOfIterations;
linecolors           	= pOpts.colormapFunction(numOfDesignFactors);

for iDesignFactor = 1 : numOfDesignFactors
   pValue       = pOpts.gLine(axesDesignFactors, iterationsVec, designFactorValues(iDesignFactor, :));
   pValue.Color = linecolors(iDesignFactor, :);
end

lDesignFactors          = legend(axesDesignFactors);
lDesignFactors.Location	= 'best';
lDesignFactors.String	=  designFactors;

end
