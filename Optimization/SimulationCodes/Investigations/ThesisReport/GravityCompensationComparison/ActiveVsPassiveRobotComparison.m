clear all
%% Initial data
numOfDUdata = 500;

%%
iIn_ActiveRobot = 1;
iFin_ActiveRobot = 1517;

load('resultsAcitveRobot.mat')
[timeVectorResults_ActiveRobot,timeVectorIds_ActiveRobot]	= unique(sort( resultsAcitveRobot.t(iIn_ActiveRobot:iFin_ActiveRobot) ));
initialTimeActive = timeVectorResults_ActiveRobot(1);
finalTimeActive = timeVectorResults_ActiveRobot(end);
durationTimeActive = (finalTimeActive-initialTimeActive);

iIn_PassiveRobot = 1;
iFin_PassiveRobot = 1233;

load('resultsPassiveRobot.mat')
[timeVectorResults_PassiveRobot,timeVectorIds_PassiveRobot]	= unique(sort( resultsPassiveRobot.t(iIn_PassiveRobot:iFin_PassiveRobot) ));
initialTimePassive = timeVectorResults_PassiveRobot(1);
finalTimePassive = timeVectorResults_PassiveRobot(end);
durationTimePassive = (finalTimePassive-initialTimePassive);

timeVector                                                  = linspace(0,min([durationTimePassive,durationTimeActive]),numOfDUdata);

%%
thetaFVectorResults_ActiveRobot         = -resultsAcitveRobot.thetaF(timeVectorIds_ActiveRobot);
thetaFDVectorResults_ActiveRobot        = -resultsAcitveRobot.thetaF_d(timeVectorIds_ActiveRobot);

thetaKVectorResults_ActiveRobot         = -resultsAcitveRobot.thetaK(timeVectorIds_ActiveRobot);
thetaKDVectorResults_ActiveRobot        = -resultsAcitveRobot.thetaK_d(timeVectorIds_ActiveRobot);

thetaFVector_ActiveRobot                = interp1(timeVectorResults_ActiveRobot', thetaFVectorResults_ActiveRobot', timeVector+initialTimeActive);
thetaFDVector_ActiveRobot               = interp1(timeVectorResults_ActiveRobot', thetaFDVectorResults_ActiveRobot', timeVector+initialTimeActive);

thetaKVector_ActiveRobot                = interp1(timeVectorResults_ActiveRobot', thetaKVectorResults_ActiveRobot', timeVector+initialTimeActive);
thetaKDVector_ActiveRobot               = interp1(timeVectorResults_ActiveRobot', thetaKDVectorResults_ActiveRobot', timeVector+initialTimeActive);

psiFVectorResults_ActiveRobot      	= -resultsAcitveRobot.psiF(timeVectorIds_ActiveRobot);
psiFDVectorResults_ActiveRobot     	= -resultsAcitveRobot.psiF_d(timeVectorIds_ActiveRobot);

psiKVectorResults_ActiveRobot       	= -resultsAcitveRobot.psiK(timeVectorIds_ActiveRobot);
psiKDVectorResults_ActiveRobot      	= -resultsAcitveRobot.psiK_d(timeVectorIds_ActiveRobot);

psiFVector_ActiveRobot           	= interp1(timeVectorResults_ActiveRobot', psiFVectorResults_ActiveRobot', timeVector+initialTimeActive);
psiFDVector_ActiveRobot              = interp1(timeVectorResults_ActiveRobot', psiFDVectorResults_ActiveRobot', timeVector+initialTimeActive);

psiKVector_ActiveRobot            	= interp1(timeVectorResults_ActiveRobot', psiKVectorResults_ActiveRobot', timeVector+initialTimeActive);
psiKDVector_ActiveRobot            	= interp1(timeVectorResults_ActiveRobot', psiKDVectorResults_ActiveRobot', timeVector+initialTimeActive);

%%

thetaFVectorResults_PassiveRobot         = -resultsPassiveRobot.thetaF(timeVectorIds_PassiveRobot);
thetaFDVectorResults_PassiveRobot        = -resultsPassiveRobot.thetaF_d(timeVectorIds_PassiveRobot);

thetaKVectorResults_PassiveRobot         = -resultsPassiveRobot.thetaK(timeVectorIds_PassiveRobot);
thetaKDVectorResults_PassiveRobot        = -resultsPassiveRobot.thetaK_d(timeVectorIds_PassiveRobot);

thetaFVector_PassiveRobot                = interp1(timeVectorResults_PassiveRobot', thetaFVectorResults_PassiveRobot', timeVector+initialTimePassive);
thetaFDVector_PassiveRobot               = interp1(timeVectorResults_PassiveRobot', thetaFDVectorResults_PassiveRobot', timeVector+initialTimePassive);

thetaKVector_PassiveRobot                = interp1(timeVectorResults_PassiveRobot', thetaKVectorResults_PassiveRobot', timeVector+initialTimePassive);
thetaKDVector_PassiveRobot               = interp1(timeVectorResults_PassiveRobot', thetaKDVectorResults_PassiveRobot', timeVector+initialTimePassive);

psiFVectorResults_PassiveRobot      	= -resultsPassiveRobot.psiF(timeVectorIds_PassiveRobot);
psiFDVectorResults_PassiveRobot     	= -resultsPassiveRobot.psiF_d(timeVectorIds_PassiveRobot);

psiKVectorResults_PassiveRobot       	= -resultsPassiveRobot.psiK(timeVectorIds_PassiveRobot);
psiKDVectorResults_PassiveRobot      	= -resultsPassiveRobot.psiK_d(timeVectorIds_PassiveRobot);

psiFVector_PassiveRobot           	= interp1(timeVectorResults_PassiveRobot', psiFVectorResults_PassiveRobot', timeVector+initialTimePassive);
psiFDVector_PassiveRobot              = interp1(timeVectorResults_PassiveRobot', psiFDVectorResults_PassiveRobot', timeVector+initialTimePassive);

psiKVector_PassiveRobot            	= interp1(timeVectorResults_PassiveRobot', psiKVectorResults_PassiveRobot', timeVector+initialTimePassive);
psiKDVector_PassiveRobot            	= interp1(timeVectorResults_PassiveRobot', psiKDVectorResults_PassiveRobot', timeVector+initialTimePassive);


%% Figures
close all
pOpts   = loadPlotOptions;

%% Comparison figure
%%% Active vs Passive robot plot
figureActiveVsPassive                     = pOpts.gFigure('Active vs Passive robot plot');
figureActiveVsPassive.Visible             = 'on';
figureActiveVsPassive.Position            = pOpts.figurePosition3;
tiledLayoutActiveVsPassive                = pOpts.gTiledLayout(figureActiveVsPassive, [4,1]);      
tiledLayoutActiveVsPassive.Title.String 	= 'Active vs Passive robot plot';

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

pFemoralActiveThetaF                        = pOpts.gLine(tileAxesActiveVsPassiveThetaF, timeVector, thetaFVector_ActiveRobot);
pFemoralActiveThetaF.Color                  = pOpts.LineColor(1,:);
ActiveVsPassiveThetaFLegend.String{end}    	= 'Active Model';

pFemoralPassiveThetaF                        = pOpts.gLine(tileAxesActiveVsPassiveThetaF, timeVector, thetaFVector_PassiveRobot);
pFemoralPassiveThetaF.Color                  = [1,0.5,0.5];
ActiveVsPassiveThetaFLegend.String{end+1}  	= '';
ActiveVsPassiveThetaFLegend.String{end}    	= 'Passive Model';
pFemoralPassiveThetaF.LineStyle             = '--';

% PsiF
tileAxesActiveVsPassivePsiF               = pOpts.gTileAxes(tiledLayoutActiveVsPassive, 2, [1,1]);
tileAxesActiveVsPassivePsiF.XGrid          = 'on';
tileAxesActiveVsPassivePsiF.YGrid          = 'on';

tileAxesActiveVsPassivePsiF.XMinorGrid     = 'on';
tileAxesActiveVsPassivePsiF.YMinorGrid     = 'off';
tileAxesActiveVsPassivePsiF.XScale         = 'linear';
tileAxesActiveVsPassivePsiF.YScale         = 'linear';

tileAxesActiveVsPassivePsiF.YLabel.String  = sprintf(['θ_{Κ} [rad]']);

ActiveVsPassivePsiFLegend               	= legend(tileAxesActiveVsPassivePsiF);
ActiveVsPassivePsiFLegend.Location       	= 'northeast';

pFemoralActivePsiF                        = pOpts.gLine(tileAxesActiveVsPassivePsiF, timeVector, psiFVector_ActiveRobot);
pFemoralActivePsiF.Color                  = pOpts.LineColor(1,:);
ActiveVsPassivePsiFLegend.String{end}    	= 'Active Model';

pFemoralPassivePsiF                        = pOpts.gLine(tileAxesActiveVsPassivePsiF, timeVector, psiFVector_PassiveRobot);
pFemoralPassivePsiF.Color                  = [1,0.5,0.5];
ActiveVsPassivePsiFLegend.String{end+1}  	= '';
ActiveVsPassivePsiFLegend.String{end}    	= 'Passive Model';
pFemoralPassivePsiF.LineStyle             = '--';

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

pFemoralActiveThetaK                        = pOpts.gLine(tileAxesActiveVsPassiveThetaK, timeVector, thetaKVector_ActiveRobot);
pFemoralActiveThetaK.Color                  = pOpts.LineColor(1,:);
ActiveVsPassiveThetaKLegend.String{end}    	= 'Active Model';

pFemoralPassiveThetaK                        = pOpts.gLine(tileAxesActiveVsPassiveThetaK, timeVector, thetaKVector_PassiveRobot);
pFemoralPassiveThetaK.Color                  = [1,0.5,0.5];
ActiveVsPassiveThetaKLegend.String{end+1}  	= '';
ActiveVsPassiveThetaKLegend.String{end}    	= 'Passive Model';
pFemoralPassiveThetaK.LineStyle             = '--';

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

pFemoralActivePsiK                        = pOpts.gLine(tileAxesActiveVsPassivePsiK, timeVector, psiKVector_ActiveRobot);
pFemoralActivePsiK.Color                  = pOpts.LineColor(1,:);
ActiveVsPassivePsiKLegend.String{end}    	= 'Active Model';

pFemoralPassivePsiK                        = pOpts.gLine(tileAxesActiveVsPassivePsiK, timeVector, psiKVector_PassiveRobot);
pFemoralPassivePsiK.Color                  = [1,0.5,0.5];
ActiveVsPassivePsiKLegend.String{end+1}  	= '';
ActiveVsPassivePsiKLegend.String{end}    	= 'Passive Model';
pFemoralPassivePsiK.LineStyle             = '--';
