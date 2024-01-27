clear all
%% Initial data
numOfDUdata = 500;

%% Insert data from simulations

% Load the matlab active robot simulation results
iIn_ActiveRobot = 1;
iFin_ActiveRobot = 1517;

load('resultsAcitveRobot.mat')
[timeVectorResults_ActiveRobot,timeVectorIds_ActiveRobot]	= unique(sort( resultsAcitveRobot.t(iIn_ActiveRobot:iFin_ActiveRobot) ));
initialTimeActive = timeVectorResults_ActiveRobot(1);
finalTimeActive = timeVectorResults_ActiveRobot(end);
durationTimeActive = (finalTimeActive-initialTimeActive);

% Load the adams results
iIn_Adams = 1529;
iFin_Adams= 1786;

load('AdamsSimulationResults.mat')
timeVectorAdamsDataResults = AdamsSimulationResults.tout(1529:1786);
thetaKVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,3);
psiKVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,4);
thetaFVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,5);
psiFVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,6);
thetaDVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,7);
thetaKDVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,10);
psiKDVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,11);
thetaFDVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,12);
psiFDVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,13);
thetaDDVectorAdamsDataResults = AdamsSimulationResults.State.Data(1529:1786,14);

initialTimeAdams = timeVectorAdamsDataResults(1);
finalTimeAdams = timeVectorAdamsDataResults(end);
durationTimeAdams = (finalTimeAdams-initialTimeAdams);

timeVector                                                  = linspace(0,min([durationTimeAdams,durationTimeActive]),numOfDUdata);

%% Process the data
thetaFVectorResults_ActiveRobot         = resultsAcitveRobot.thetaF(timeVectorIds_ActiveRobot);
thetaFDVectorResults_ActiveRobot        = resultsAcitveRobot.thetaF_d(timeVectorIds_ActiveRobot);

thetaKVectorResults_ActiveRobot         = resultsAcitveRobot.thetaK(timeVectorIds_ActiveRobot);
thetaKDVectorResults_ActiveRobot        = resultsAcitveRobot.thetaK_d(timeVectorIds_ActiveRobot);

thetaFVector_ActiveRobot                = interp1(timeVectorResults_ActiveRobot', thetaFVectorResults_ActiveRobot', timeVector+initialTimeActive);
thetaFDVector_ActiveRobot               = interp1(timeVectorResults_ActiveRobot', thetaFDVectorResults_ActiveRobot', timeVector+initialTimeActive);

thetaKVector_ActiveRobot                = interp1(timeVectorResults_ActiveRobot', thetaKVectorResults_ActiveRobot', timeVector+initialTimeActive);
thetaKDVector_ActiveRobot               = interp1(timeVectorResults_ActiveRobot', thetaKDVectorResults_ActiveRobot', timeVector+initialTimeActive);

psiFVectorResults_ActiveRobot           = resultsAcitveRobot.psiF(timeVectorIds_ActiveRobot);
psiFDVectorResults_ActiveRobot          = resultsAcitveRobot.psiF_d(timeVectorIds_ActiveRobot);

psiKVectorResults_ActiveRobot       	= resultsAcitveRobot.psiK(timeVectorIds_ActiveRobot);
psiKDVectorResults_ActiveRobot      	= resultsAcitveRobot.psiK_d(timeVectorIds_ActiveRobot);

psiFVector_ActiveRobot                  = interp1(timeVectorResults_ActiveRobot', psiFVectorResults_ActiveRobot', timeVector+initialTimeActive);
psiFDVector_ActiveRobot                 = interp1(timeVectorResults_ActiveRobot', psiFDVectorResults_ActiveRobot', timeVector+initialTimeActive);

psiKVector_ActiveRobot                  = interp1(timeVectorResults_ActiveRobot', psiKVectorResults_ActiveRobot', timeVector+initialTimeActive);
psiKDVector_ActiveRobot                 = interp1(timeVectorResults_ActiveRobot', psiKDVectorResults_ActiveRobot', timeVector+initialTimeActive);

%%

thetaFVectorAdamsData                = interp1(timeVectorAdamsDataResults', thetaFVectorAdamsDataResults', timeVector+initialTimeAdams);
thetaFDVectorAdamsData               = interp1(timeVectorAdamsDataResults', thetaFDVectorAdamsDataResults', timeVector+initialTimeAdams);

thetaKVectorAdamsData                = interp1(timeVectorAdamsDataResults', thetaKVectorAdamsDataResults', timeVector+initialTimeAdams);
thetaKDVectorAdamsData               = interp1(timeVectorAdamsDataResults', thetaKDVectorAdamsDataResults', timeVector+initialTimeAdams);

psiFVectorAdamsData                 = interp1(timeVectorAdamsDataResults', psiFVectorAdamsDataResults', timeVector+initialTimeAdams);
psiFDVectorAdamsData                = interp1(timeVectorAdamsDataResults', psiFDVectorAdamsDataResults', timeVector+initialTimeAdams);

psiKVectorAdamsData                 = interp1(timeVectorAdamsDataResults', psiKVectorAdamsDataResults', timeVector+initialTimeAdams);
psiKDVectorAdamsData            	= interp1(timeVectorAdamsDataResults', psiKDVectorAdamsDataResults', timeVector+initialTimeAdams);


%% Figures
close all
pOpts   = loadPlotOptions;

%% Comparison figure
%%% Active vs Passive robot plot
figureActiveVsPassive                     = pOpts.gFigure('Active vs Passive robot plot');
figureActiveVsPassive.Visible             = 'on';
figureActiveVsPassive.Position            = pOpts.figurePosition3;
tiledLayoutActiveVsPassive                = pOpts.gTiledLayout(figureActiveVsPassive, [4,1]);      
tiledLayoutActiveVsPassive.Title.String 	= 'Matlab vs Adams Simulation';

% ThetaF
tileAxesActiveVsPassiveThetaF               = pOpts.gTileAxes(tiledLayoutActiveVsPassive, 1, [1,1]);
tileAxesActiveVsPassiveThetaF.XGrid          = 'on';
tileAxesActiveVsPassiveThetaF.YGrid          = 'on';

tileAxesActiveVsPassiveThetaF.XMinorGrid     = 'on';
tileAxesActiveVsPassiveThetaF.YMinorGrid     = 'off';
tileAxesActiveVsPassiveThetaF.XScale         = 'linear';
tileAxesActiveVsPassiveThetaF.YScale         = 'linear';

tileAxesActiveVsPassiveThetaF.YLabel.String  = sprintf(['θ_{F} [rad]']);

ActiveVsPassiveThetaFLegend               	= legend(tileAxesActiveVsPassiveThetaF);
ActiveVsPassiveThetaFLegend.Location       	= 'northeast';

pFemoralActiveThetaF                     	= pOpts.gLine(tileAxesActiveVsPassiveThetaF, timeVector, thetaFVector_ActiveRobot);
pFemoralActiveThetaF.Color                  = pOpts.LineColor(1,:);
ActiveVsPassiveThetaFLegend.String{end}   	= 'Active';
% 
pFemoralPassiveThetaF                     	= pOpts.gLine(tileAxesActiveVsPassiveThetaF, timeVector, thetaFVectorAdamsData);
pFemoralPassiveThetaF.Color               	= [1,0.5,0.5];
ActiveVsPassiveThetaFLegend.String{end+1}  	= '';
ActiveVsPassiveThetaFLegend.String{end}    	= 'Adams';

% PsiF
tileAxesActiveVsPassivePsiF               = pOpts.gTileAxes(tiledLayoutActiveVsPassive, 2, [1,1]);
tileAxesActiveVsPassivePsiF.XGrid          = 'on';
tileAxesActiveVsPassivePsiF.YGrid          = 'on';

tileAxesActiveVsPassivePsiF.XMinorGrid     = 'on';
tileAxesActiveVsPassivePsiF.YMinorGrid     = 'off';
tileAxesActiveVsPassivePsiF.XScale         = 'linear';
tileAxesActiveVsPassivePsiF.YScale         = 'linear';

tileAxesActiveVsPassivePsiF.YLabel.String  = sprintf(['Ψ_{F} [rad]']);

ActiveVsPassivePsiFLegend               	= legend(tileAxesActiveVsPassivePsiF);
ActiveVsPassivePsiFLegend.Location       	= 'northeast';
% 
pFemoralActivePsiF                        = pOpts.gLine(tileAxesActiveVsPassivePsiF, timeVector, psiFVector_ActiveRobot);
pFemoralActivePsiF.Color                  = pOpts.LineColor(1,:);
ActiveVsPassivePsiFLegend.String{end}   	= 'Active';

pFemoralPassivePsiF                     	= pOpts.gLine(tileAxesActiveVsPassivePsiF, timeVector, psiFVectorAdamsData);
pFemoralPassivePsiF.Color               	= [1,0.5,0.5];
ActiveVsPassivePsiFLegend.String{end+1}  	= '';
ActiveVsPassivePsiFLegend.String{end}    	= 'Adams';

% ThetaK
tileAxesActiveVsPassiveThetaK               = pOpts.gTileAxes(tiledLayoutActiveVsPassive, 3, [1,1]);
tileAxesActiveVsPassiveThetaK.XGrid          = 'on';
tileAxesActiveVsPassiveThetaK.YGrid          = 'on';

tileAxesActiveVsPassiveThetaK.XMinorGrid     = 'on';
tileAxesActiveVsPassiveThetaK.YMinorGrid     = 'off';
tileAxesActiveVsPassiveThetaK.XScale         = 'linear';
tileAxesActiveVsPassiveThetaK.YScale         = 'linear';

tileAxesActiveVsPassiveThetaK.YLabel.String  = sprintf(['θ_{Κ} [rad]']);

ActiveVsPassiveThetaKLegend               	= legend(tileAxesActiveVsPassiveThetaK);
ActiveVsPassiveThetaKLegend.Location       	= 'northeast';
% 
pFemoralActiveThetaK                        = pOpts.gLine(tileAxesActiveVsPassiveThetaK, timeVector, thetaKVector_ActiveRobot);
pFemoralActiveThetaK.Color                  = pOpts.LineColor(1,:);
ActiveVsPassiveThetaKLegend.String{end}   	= 'Active';

pFemoralPassiveThetaK                     	= pOpts.gLine(tileAxesActiveVsPassiveThetaK, timeVector, thetaKVectorAdamsData);
pFemoralPassiveThetaK.Color               	= [1,0.5,0.5];
ActiveVsPassiveThetaKLegend.String{end+1}  	= '';
ActiveVsPassiveThetaKLegend.String{end}    	= 'Adams';

% PsiK
tileAxesActiveVsPassivePsiK               = pOpts.gTileAxes(tiledLayoutActiveVsPassive, 4, [1,1]);
tileAxesActiveVsPassivePsiK.XGrid          = 'on';
tileAxesActiveVsPassivePsiK.YGrid          = 'on';

tileAxesActiveVsPassivePsiK.XMinorGrid     = 'on';
tileAxesActiveVsPassivePsiK.YMinorGrid     = 'off';
tileAxesActiveVsPassivePsiK.XScale         = 'linear';
tileAxesActiveVsPassivePsiK.YScale         = 'linear';

tileAxesActiveVsPassivePsiK.XLabel.String  = 'Time [sec]';
tileAxesActiveVsPassivePsiK.YLabel.String  = sprintf(['Ψ_{Κ} [rad]']);

ActiveVsPassivePsiKLegend               	= legend(tileAxesActiveVsPassivePsiK);
ActiveVsPassivePsiKLegend.Location       	= 'northeast';
% 
pFemoralActivePsiK                        = pOpts.gLine(tileAxesActiveVsPassivePsiK, timeVector, psiKVector_ActiveRobot);
pFemoralActivePsiK.Color                  = pOpts.LineColor(1,:);
ActiveVsPassivePsiKLegend.String{end}   	= 'Active';

pFemoralPassivePsiK                     	= pOpts.gLine(tileAxesActiveVsPassivePsiK, timeVector, psiKVectorAdamsData);
pFemoralPassivePsiK.Color               	= [1,0.5,0.5];
ActiveVsPassivePsiKLegend.String{end+1}  	= '';
ActiveVsPassivePsiKLegend.String{end}    	= 'Adams';
