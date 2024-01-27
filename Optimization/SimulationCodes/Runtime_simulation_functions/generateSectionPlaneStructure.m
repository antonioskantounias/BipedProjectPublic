function sectionPlane = generateSectionPlaneStructure(sectionPlaneName)
%% generateSectionPlaneStructure 
% Description:  This function generates the simulation's section plane structure. Section plane is defined as state which
%               respects a condition. In order to have a better understanding of the section plane structure read: C:\Projects\BipedProject\Reports\SectionPlane.docx
%               This structure contains all the section plane related data and function.
% 
% Inputs:       sectionPlaneName:   char array that contains the name of the section plane that will be used. 
%
% Outputs:      sectionPlane:       struct that contains all the functions and data related to the section plane.
%                                   1) The unconstrained states of the system
%                                   2) The constrained states of the system
%                                   3) The return map function that corresponds to the section plane
%                                   4) The function that calculates and move the constrained state variables on the section plane space
%                                   based on the values of the unconstrained variables.
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

sectionPlane.Name   = sectionPlaneName;

switch sectionPlaneName
    case {'AH'}
        sectionPlane.VariablesUnconstrained         = {     'thetaK';
                                                            'psiF';
                                                            'psiK';
                                                            'thetaF_d';
                                                            'thetaK_d';
                                                            'psiF_d';
                                                            'psiK_d'    };
                                                    
        sectionPlane.VariablesConstrained           = {     'thetaF'    };
        
        sectionPlane.runReturnSequence              = @(simulationParameters, options, results) runReturnSequence4AH(simulationParameters, options, results);
       
        sectionPlane.calculateThetaF                = @(    thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel)...
                                                            calculateThetaF4AH(	thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel); 
                                                                   
        sectionPlane.moveConditionsOnSectionPlane	= @(    conditions, parametersModel)...
                                                            moveConditionsOnSectionPlane4AH(conditions, parametersModel);
                                                        
    	sectionPlane.transformUnconstrainedVariablesVector2Conditions   = @(unconstrainedVariablesVector, parametersModel)...
                                                                            transformUnconstrainedVariablesVector2Conditions4AH(unconstrainedVariablesVector, parametersModel);

        sectionPlane.transformConditions2UnconstrainedVariablesVector   = @(conditions)...
                                                                            transformConditions2UnconstrainedVariablesVector4AH(conditions);
                                                                        
        sectionPlane.initialFoot                    = 1; 
        
    case {'AH_GC'}
        sectionPlane.VariablesUnconstrained         = {     'thetaK';
            'psiF';
            'psiK';
            'thetaF_d';
            'thetaK_d';
            'psiF_d';
            'psiK_d'    };
        
        sectionPlane.VariablesConstrained           = {     'thetaF'    };
        
        sectionPlane.runReturnSequence              = @(simulationParameters, options, results) runReturnSequence4AH_GC(simulationParameters, options, results);
        
        sectionPlane.calculateThetaF                = @(    thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel)...
            calculateThetaF4AH(	thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel);
        
        sectionPlane.moveConditionsOnSectionPlane	= @(    conditions, parametersModel)...
            moveConditionsOnSectionPlane4AH(conditions, parametersModel);
        
        sectionPlane.transformUnconstrainedVariablesVector2Conditions   = @(unconstrainedVariablesVector, parametersModel)...
            transformUnconstrainedVariablesVector2Conditions4AH(unconstrainedVariablesVector, parametersModel);
        
        sectionPlane.transformConditions2UnconstrainedVariablesVector   = @(conditions)...
            transformConditions2UnconstrainedVariablesVector4AH(conditions);
        
        sectionPlane.initialFoot                    = 1;

     case {'AH2'}
        sectionPlane.VariablesUnconstrained         = {     'thetaK';
                                                            'psiF';
                                                            'psiK';
                                                            'thetaF_d';
                                                            'thetaK_d';
                                                            'psiF_d';
                                                            'psiK_d'    };
                                                    
        sectionPlane.VariablesConstrained           = {     'thetaF'    };
        
        sectionPlane.runReturnSequence              = @(simulationParameters, options, results) runReturnSequence4AH2(simulationParameters, options, results);
       
        sectionPlane.calculateThetaF                = @(    thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel)...
                                                            calculateThetaF4AH(	thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel); 
                                                                   
        sectionPlane.moveConditionsOnSectionPlane	= @(    conditions, parametersModel)...
                                                            moveConditionsOnSectionPlane4AH(conditions, parametersModel);
                                                        
    	sectionPlane.transformUnconstrainedVariablesVector2Conditions   = @(unconstrainedVariablesVector, parametersModel)...
                                                                            transformUnconstrainedVariablesVector2Conditions4AH(unconstrainedVariablesVector, parametersModel);

        sectionPlane.transformConditions2UnconstrainedVariablesVector   = @(conditions)...
                                                                            transformConditions2UnconstrainedVariablesVector4AH(conditions);
                                                                        
        sectionPlane.initialFoot                    = 1; 

     case {'AH2_GC'}
        sectionPlane.VariablesUnconstrained         = {     'thetaK';
                                                            'psiF';
                                                            'psiK';
                                                            'thetaF_d';
                                                            'thetaK_d';
                                                            'psiF_d';
                                                            'psiK_d'    };
                                                    
        sectionPlane.VariablesConstrained           = {     'thetaF'    };
        
        sectionPlane.runReturnSequence              = @(simulationParameters, options, results) runReturnSequence4AH2_GC(simulationParameters, options, results);
       
        sectionPlane.calculateThetaF                = @(    thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel)...
                                                            calculateThetaF4AH(	thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel); 
                                                                   
        sectionPlane.moveConditionsOnSectionPlane	= @(    conditions, parametersModel)...
                                                            moveConditionsOnSectionPlane4AH(conditions, parametersModel);
                                                        
    	sectionPlane.transformUnconstrainedVariablesVector2Conditions   = @(unconstrainedVariablesVector, parametersModel)...
                                                                            transformUnconstrainedVariablesVector2Conditions4AH(unconstrainedVariablesVector, parametersModel);

        sectionPlane.transformConditions2UnconstrainedVariablesVector   = @(conditions)...
                                                                            transformConditions2UnconstrainedVariablesVector4AH(conditions);
                                                                        
        sectionPlane.initialFoot                    = 1; 
        
    otherwise 
        errorMessage    = sprintf('Please select a valid section plane \n');
        error(errorMessage);
end

end

function conditions = moveConditionsOnSectionPlane4AH(conditions, parametersModel)

% Extract state variable values
thetaK          	= conditions.q(2);
psiF                = conditions.q(3);
psiK                = conditions.q(4);
thetaF_d          	= conditions.qd(1);
thetaK_d          	= conditions.qd(2);
psiF_d          	= conditions.qd(3);
psiK_d          	= conditions.qd(4);

% Calculate dependent that coresponds apex height to section plane
thetaF              = calculateThetaF4AH(thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel);

% Update conditions structure
conditions.q        = [thetaF, thetaK, psiF, psiK];
conditions.qd       = [thetaF_d, thetaK_d, psiF_d, psiK_d];
    
end

function conditions = transformUnconstrainedVariablesVector2Conditions4AH(unconstrainedVariablesVector, parametersModel)

thetaK          	= unconstrainedVariablesVector(1);
psiF                = unconstrainedVariablesVector(2);
psiK                = unconstrainedVariablesVector(3);
thetaF_d          	= unconstrainedVariablesVector(4);
thetaK_d          	= unconstrainedVariablesVector(5);
psiF_d          	= unconstrainedVariablesVector(6);
psiK_d          	= unconstrainedVariablesVector(7);
thetaF              = calculateThetaF4AH(thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel);

conditions.q        = [thetaF, thetaK, psiF, psiK];
conditions.qd       = [thetaF_d, thetaK_d, psiF_d, psiK_d];
    
end

function unconstrainedVariablesVector = transformConditions2UnconstrainedVariablesVector4AH(conditions)

unconstrainedVariablesVector = [conditions.q(2:end), conditions.qd(1:end)];
    
end

function thetaF = calculateThetaF4AH(thetaF_d, thetaK, thetaK_d, psiF, psiF_d, psiK, psiK_d, parametersModel, varargin)  
% Newton raphson parameters
p = inputParser;
p.addParameter('max_iter',100);
p.addParameter('tol',1e-15);

p.parse(varargin{:})
max_iter   	= p.Results.max_iter;
tol         = p.Results.tol;

% Model Parameters
L1F         = parametersModel.L1F;
L1T         = parametersModel.L1T;
l1          = parametersModel.l1;       
l2          = parametersModel.l2;       
l3          = parametersModel.l3;   
l4          = parametersModel.l4;   
l5          = parametersModel.l5;   
l6          = parametersModel.l6;
ksiF        = parametersModel.ksiF;   
ksiT        = parametersModel.ksiT;
footshape   = parametersModel.footshape;

% Calcualte thetaF based on the unconstrained state variables. (Here x = thetaF)

% Pre-calculations for the constrain function call.
thetaT              = @(x) thetaT_calc(ksiF,ksiT,l1,l2,l3,l4,x,thetaK);
dyAnkle_dthetaT     = @(x) interp1(footshape.psi, footshape.dc2y_dps, thetaT(x));
dyAnkle_d           = @(x) dyAnkle_dthetaT(x) * (DthT_DthF * thetaF_d + DthT_DthK(l1,l2,l3,l4,thetaK) * thetaK_d);

% Pre calculations for constraint function derivative with respect to thetaF call.
ddyAnkle_ddthetaT   = @(x) interp1(footshape.psi, footshape.ddyc2_ddps, thetaT(x));
DdyAnkle_d_DthetaF	= @(x)  ddyAnkle_ddthetaT(x) * DthT_DthF * 	( DthT_DthF * thetaF_d + DthT_DthK(l1,l2,l3,l4,thetaK) * thetaK_d) + ...
                        	dyAnkle_dthetaT(x) *                (DDthT_DDthF * thetaF_d + DDthT_DthKDthF * thetaK_d );

% Run newton raphson algorithm
f                                           = @(x) yH_d_Function(L1F,L1T,dyAnkle_d(x),ksiF,ksiT,l1,l2,l3,l4,l5,l6,x,thetaK,thetaF_d,thetaK_d);                              % Function to find root of
df                                          = @(x) DyH_d_Function_DthetaF(DdyAnkle_d_DthetaF(x),L1F,L1T,ksiF,ksiT,l1,l2,l3,l4,l5,l6,x,thetaK,thetaF_d,thetaK_d);            % Derivative of function
x0                                          = 0;                                                                                                                            % Initial guess
[thetaF, ~]                                 = calculateRootByNewtonRaphson(f, df, x0, tol, max_iter);

end

function results        = runReturnSequence4AH(simulationParameters, options, results)

% Run single stance phase of the foot 1 till the hill strike event
results                 = run_SSP1(simulationParameters, options, results);

% Run double stance phase till toe off
results                 = run_DSP12(simulationParameters, options, results);

% Run single stance phase of the foot 2 till apex height event
results                 = run_SSP2TillMaxHeight(simulationParameters, options, results);
    
end

function results        = runReturnSequence4AH_GC(simulationParameters, options, results)

% Run single stance phase of the foot 1 till the hill strike event
results                 = run_SSP1_GC(simulationParameters, options, results);

% Run double stance phase till toe off
results                 = run_DSP12(simulationParameters, options, results);

% Run single stance phase of the foot 2 till apex height event
results                 = run_SSP2TillMaxHeight_GC(simulationParameters, options, results);
    
end

function results        = runReturnSequence4AH2(simulationParameters, options, results)

% Run single stance phase of the foot 1 till the hill strike event
results                 = run_SSP1(simulationParameters, options, results);

% Run double stance phase till toe off
results                 = run_DSP12(simulationParameters, options, results);

% Run single stance phase of the foot 2 till apex height event
results                 = run_SSP2TillMaxHeight(simulationParameters, options, results);

% Run single stance phase of the foot 1 till the hill strike event
results                 = run_SSP2(simulationParameters, options, results);

% Run double stance phase till toe off
results                 = run_DSP21(simulationParameters, options, results);

% Run single stance phase of the foot 2 till apex height event
results                 = run_SSP1TillMaxHeight(simulationParameters, options, results);
    
end

function results        = runReturnSequence4AH2_GC(simulationParameters, options, results)

% Run single stance phase of the foot 1 till the hill strike event
results                 = run_SSP1_GC(simulationParameters, options, results);

% Run double stance phase till toe off
results                 = run_DSP12(simulationParameters, options, results);

% Run single stance phase of the foot 2 till apex height event
results                 = run_SSP2TillMaxHeight_GC(simulationParameters, options, results);

% Run single stance phase of the foot 1 till the hill strike event
results                 = run_SSP2_GC(simulationParameters, options, results);

% Run double stance phase till toe off
results                 = run_DSP21(simulationParameters, options, results);

% Run single stance phase of the foot 2 till apex height event
results                 = run_SSP1TillMaxHeight_GC(simulationParameters, options, results);
    
end