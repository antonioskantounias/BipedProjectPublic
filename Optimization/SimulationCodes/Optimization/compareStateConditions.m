function [areConditionsSimilar, resemblanceMetrics] = compareStateConditions(stateConditions1, stateConditions2, varargin)
%% compareStateConditions 
% Description:  This function takes as inputs tow stateConditions and calculates the absolute and the relative difference
%               of the state variables.
% 
% Inputs:       stateConditions{1,2}:   struct that contains the reduced robot's state in the form of
%                                       1) angular displacements. (stateConditions.q = [thetaF, thetaK, psiF, psiK])
%                                       2) angular velocities. (stateConditions.qd = [thetaF_d, thetaK_d, psiF_d, psiK_d])
%
% Outputs:      areConditionsSimilar:   logical flag that indicates if the tow condition states can be considered equal based
%                                       on their relative difference.
%
%               resemblanceMetrics:     struct that takes contains the comparison between to state condition. As field you can find:
%                                       1) The state conditions1. (stateConditions1)
%                                       2) The state conditions2. (stateConditions2)
%                                       3) The absolute difference between the tow state conditions e.g. thetaF1 - thetaF2. (DifferenceAbsolute)
%                                       4) The relative difference between the tow state conditions e.g. (thetaF1 - thetaF2)/thetaF1. (DifferenceRelative)
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com.

%% Add parameters
p = inputParser;
p.addParameter('criterionResemblance', 1e-6);       % Maximum relative difference between the state variables threshold used to define similarity or not.
p.addParameter('footInterchange', false);           % Flag that is activated if the comparison of the simetrical foot is needed.

p.parse(varargin{:})
criterionResemblance    = p.Results.criterionResemblance;
footInterchange         = p.Results.footInterchange;

%% Resemblance feature initialization
areConditionsSimilar = true;

%% Calcualate resemblance based on the resemblance criterion
% Change the conditions of initial state in case there is foot intersection
if footInterchange
    stateConditions1   = interchangeFootCondition(stateConditions1);
end

% State variables
thetaF1   	= stateConditions1.q(1);
thetaK1    	= stateConditions1.q(2);
psiF1      	= stateConditions1.q(3);
psiK1     	= stateConditions1.q(4);
thetaF_d1  	= stateConditions1.qd(1);
thetaK_d1 	= stateConditions1.qd(2);
psiF_d1   	= stateConditions1.qd(3);
psiK_d1   	= stateConditions1.qd(4);

thetaF2  	= stateConditions2.q(1);
thetaK2 	= stateConditions2.q(2);
psiF2    	= stateConditions2.q(3);
psiK2       = stateConditions2.q(4);
thetaF_d2	= stateConditions2.qd(1);
thetaK_d2	= stateConditions2.qd(2);
psiF_d2  	= stateConditions2.qd(3);
psiK_d2 	= stateConditions2.qd(4);

% Absolute difference of the state variables
thetaFDifferenceAbsolute 	= thetaF1   -	thetaF2;
thetaKDifferenceAbsolute    = thetaK1   - 	thetaK2;
psiFDifferenceAbsolute      = psiF1     - 	psiF2;
psiKDifferenceAbsolute    	= psiK1 	-  	psiK2;
thetaF_dDifferenceAbsolute	= thetaF_d1	-   thetaF_d2;
thetaK_dDifferenceAbsolute	= thetaK_d1 -   thetaK_d2;
psiF_dDifferenceAbsolute    = psiF_d1   -  	psiF_d2;
psiK_dDifferenceAbsolute    = psiK_d1   -  	psiK_d2;

% Relative difference of the state variables
thetaFDifferenceRelative    = abs(thetaFDifferenceAbsolute      / 	thetaF1);
thetaKDifferenceRelative    = abs(thetaKDifferenceAbsolute      /  	thetaF1);
psiFDifferenceRelative      = abs(psiFDifferenceAbsolute        /  	thetaF1);
psiKDifferenceRelative      = abs(psiKDifferenceAbsolute        /  	thetaF1);
thetaF_dDifferenceRelative	= abs(thetaF_dDifferenceAbsolute    /	thetaF1);
thetaK_dDifferenceRelative	= abs(thetaK_dDifferenceAbsolute    /   thetaF1);
psiF_dDifferenceRelative    = abs(psiF_dDifferenceAbsolute      /  	thetaF1);
psiK_dDifferenceRelative    = abs(psiK_dDifferenceAbsolute      /  	thetaF1);

% Vector with the state variables that are similar
resemblanceVector           =  [thetaFDifferenceRelative    < 	criterionResemblance;
                               	thetaKDifferenceRelative    <  	criterionResemblance;
                                psiFDifferenceRelative      <  	criterionResemblance;
                                psiKDifferenceRelative      <  	criterionResemblance;
                                thetaF_dDifferenceRelative  <  	criterionResemblance;
                                thetaK_dDifferenceRelative  <  	criterionResemblance;
                                psiF_dDifferenceRelative    < 	criterionResemblance;
                                psiK_dDifferenceRelative    <  	criterionResemblance];

if any(resemblanceVector == false)
    areConditionsSimilar = false;
end
                                
%% Save the calculated metrics
resemblanceMetrics.stateConditions1.thetaF   	= thetaF1;
resemblanceMetrics.stateConditions1.thetaK   	= thetaK1;
resemblanceMetrics.stateConditions1.psiF       	= psiF1;
resemblanceMetrics.stateConditions1.psiK      	= psiK1;
resemblanceMetrics.stateConditions1.thetaF_d   	= thetaF_d1;
resemblanceMetrics.stateConditions1.thetaK_d   	= thetaK_d1;
resemblanceMetrics.stateConditions1.psiF_d   	= psiF_d1;
resemblanceMetrics.stateConditions1.psiK_d   	= psiK_d1;

resemblanceMetrics.stateConditions2.thetaF  	= thetaF2;
resemblanceMetrics.stateConditions2.thetaK      = thetaK2;
resemblanceMetrics.stateConditions2.psiF        = psiF2;
resemblanceMetrics.stateConditions2.psiK        = psiK2;
resemblanceMetrics.stateConditions2.thetaF_d	= thetaF_d2;
resemblanceMetrics.stateConditions2.thetaK_d	= thetaK_d2;
resemblanceMetrics.stateConditions2.psiF_d      = psiF_d2;
resemblanceMetrics.stateConditions2.psiK_d      = psiK_d2;

resemblanceMetrics.DifferenceAbsolute.thetaF   	= thetaFDifferenceAbsolute;
resemblanceMetrics.DifferenceAbsolute.thetaK   	= thetaKDifferenceAbsolute;
resemblanceMetrics.DifferenceAbsolute.psiF    	= psiFDifferenceAbsolute;
resemblanceMetrics.DifferenceAbsolute.psiK     	= psiKDifferenceAbsolute;
resemblanceMetrics.DifferenceAbsolute.thetaF_d 	= thetaF_dDifferenceAbsolute;
resemblanceMetrics.DifferenceAbsolute.thetaK_d 	= thetaK_dDifferenceAbsolute;
resemblanceMetrics.DifferenceAbsolute.psiF_d   	= psiF_dDifferenceAbsolute;
resemblanceMetrics.DifferenceAbsolute.psiK_d   	= psiK_dDifferenceAbsolute;

resemblanceMetrics.DifferenceAbsolute.Maximum 	= max(     [thetaFDifferenceAbsolute;
                                                            thetaKDifferenceAbsolute;
                                                            psiFDifferenceAbsolute;
                                                            psiKDifferenceAbsolute;
                                                            thetaF_dDifferenceAbsolute;
                                                            thetaK_dDifferenceAbsolute;
                                                            psiF_dDifferenceAbsolute;
                                                            psiK_dDifferenceAbsolute]  );

resemblanceMetrics.DifferenceRelative.thetaF   	= thetaFDifferenceRelative;
resemblanceMetrics.DifferenceRelative.thetaK  	= thetaKDifferenceRelative;
resemblanceMetrics.DifferenceRelative.psiF     	= psiFDifferenceRelative;
resemblanceMetrics.DifferenceRelative.psiK     	= psiKDifferenceRelative;
resemblanceMetrics.DifferenceRelative.thetaF_d 	= thetaF_dDifferenceRelative;
resemblanceMetrics.DifferenceRelative.thetaK_d 	= thetaK_dDifferenceRelative;
resemblanceMetrics.DifferenceRelative.psiF_d   	= psiF_dDifferenceRelative;
resemblanceMetrics.DifferenceRelative.psiK_d   	= psiK_dDifferenceRelative;

resemblanceMetrics.DifferenceRelative.Maximum 	= max(     [thetaFDifferenceRelative;
                                                            thetaKDifferenceRelative;
                                                            psiFDifferenceRelative;
                                                            psiKDifferenceRelative;
                                                            thetaF_dDifferenceRelative;
                                                            thetaK_dDifferenceRelative;
                                                            psiF_dDifferenceRelative;
                                                            psiK_dDifferenceRelative]  );
end
