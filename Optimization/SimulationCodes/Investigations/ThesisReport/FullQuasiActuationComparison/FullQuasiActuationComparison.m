clear all
%% Initial data
numOfDUdata = 500;

%%
iIn_Quasi_M06_08 = 4280;
iFin_Quasi_M06_08 = 6401;

load('results4QuasiActuators_M06_08.mat')
[timeVectorResults_Quasi_M06_08,timeVectorIds_Quasi_M06_08]	= unique(sort( results4QuasiActuators_M06_08.t(iIn_Quasi_M06_08:iFin_Quasi_M06_08) ));
initialTimeQuasi_M06_08 = timeVectorResults_Quasi_M06_08(1);
finalTimeQuasi_M06_08 = timeVectorResults_Quasi_M06_08(end);
durationTimeQuasi_M06_08 = (finalTimeQuasi_M06_08-initialTimeQuasi_M06_08);

iIn_Quasi_M06_M06 = 4427;
iFin_Quasi_M06_M06 = 5877;

load('results4QuasiActuators_M06_M06.mat')
[timeVectorResults_Quasi_M06_M06,timeVectorIds_Quasi_M06_M06]	= unique(sort( results4QuasiActuators_M06_M06.t(iIn_Quasi_M06_M06:iFin_Quasi_M06_M06) ));
initialTimeQuasi_M06_M06 = timeVectorResults_Quasi_M06_M06(1);
finalTimeQuasi_M06_M06 = timeVectorResults_Quasi_M06_M06(end);
durationTimeQuasi_M06_M06 = (finalTimeQuasi_M06_M06-initialTimeQuasi_M06_M06);

iIn_Quasi_M06_M10 = 4386;
iFin_Quasi_M06_M10 = 5839;

load('results4QuasiActuators_M06_M10.mat')
[timeVectorResults_Quasi_M06_M10,timeVectorIds_Quasi_M06_M10]	= unique(sort( results4QuasiActuators_M06_M10.t(iIn_Quasi_M06_M10:iFin_Quasi_M06_M10) ));
initialTimeQuasi_M06_M10 = timeVectorResults_Quasi_M06_M10(1);
finalTimeQuasi_M06_M10 = timeVectorResults_Quasi_M06_M10(end);
durationTimeQuasi_M06_M10 = (finalTimeQuasi_M06_M10-initialTimeQuasi_M06_M10);

timeVector                                                  = linspace(0,min([durationTimeQuasi_M06_M10,durationTimeQuasi_M06_M06,durationTimeQuasi_M06_08]),numOfDUdata);

%%
thetaFVectorResults_Quasi_M06_08         = -results4QuasiActuators_M06_08.thetaF(timeVectorIds_Quasi_M06_08);
thetaFDVectorResults_Quasi_M06_08        = -results4QuasiActuators_M06_08.thetaF_d(timeVectorIds_Quasi_M06_08);

thetaKVectorResults_Quasi_M06_08         = -results4QuasiActuators_M06_08.thetaK(timeVectorIds_Quasi_M06_08);
thetaKDVectorResults_Quasi_M06_08        = -results4QuasiActuators_M06_08.thetaK_d(timeVectorIds_Quasi_M06_08);

thetaFVector_Quasi_M06_08                = interp1(timeVectorResults_Quasi_M06_08', thetaFVectorResults_Quasi_M06_08', timeVector+initialTimeQuasi_M06_08);
thetaFDVector_Quasi_M06_08               = interp1(timeVectorResults_Quasi_M06_08', thetaFDVectorResults_Quasi_M06_08', timeVector+initialTimeQuasi_M06_08);

thetaKVector_Quasi_M06_08                = interp1(timeVectorResults_Quasi_M06_08', thetaKVectorResults_Quasi_M06_08', timeVector+initialTimeQuasi_M06_08);
thetaKDVector_Quasi_M06_08               = interp1(timeVectorResults_Quasi_M06_08', thetaKDVectorResults_Quasi_M06_08', timeVector+initialTimeQuasi_M06_08);

psiFVectorResults_Quasi_M06_08      	= -results4QuasiActuators_M06_08.psiF(timeVectorIds_Quasi_M06_08);
psiFDVectorResults_Quasi_M06_08     	= -results4QuasiActuators_M06_08.psiF_d(timeVectorIds_Quasi_M06_08);

psiKVectorResults_Quasi_M06_08       	= -results4QuasiActuators_M06_08.psiK(timeVectorIds_Quasi_M06_08);
psiKDVectorResults_Quasi_M06_08      	= -results4QuasiActuators_M06_08.psiK_d(timeVectorIds_Quasi_M06_08);

psiFVector_Quasi_M06_08           	= interp1(timeVectorResults_Quasi_M06_08', psiFVectorResults_Quasi_M06_08', timeVector+initialTimeQuasi_M06_08);
psiFDVector_Quasi_M06_08              = interp1(timeVectorResults_Quasi_M06_08', psiFDVectorResults_Quasi_M06_08', timeVector+initialTimeQuasi_M06_08);

psiKVector_Quasi_M06_08            	= interp1(timeVectorResults_Quasi_M06_08', psiKVectorResults_Quasi_M06_08', timeVector+initialTimeQuasi_M06_08);
psiKDVector_Quasi_M06_08            	= interp1(timeVectorResults_Quasi_M06_08', psiKDVectorResults_Quasi_M06_08', timeVector+initialTimeQuasi_M06_08);

%%

thetaFVectorResults_Quasi_M06_M06         = -results4QuasiActuators_M06_M06.thetaF(timeVectorIds_Quasi_M06_M06);
thetaFDVectorResults_Quasi_M06_M06        = -results4QuasiActuators_M06_M06.thetaF_d(timeVectorIds_Quasi_M06_M06);

thetaKVectorResults_Quasi_M06_M06         = -results4QuasiActuators_M06_M06.thetaK(timeVectorIds_Quasi_M06_M06);
thetaKDVectorResults_Quasi_M06_M06        = -results4QuasiActuators_M06_M06.thetaK_d(timeVectorIds_Quasi_M06_M06);

thetaFVector_Quasi_M06_M06                = interp1(timeVectorResults_Quasi_M06_M06', thetaFVectorResults_Quasi_M06_M06', timeVector+initialTimeQuasi_M06_M06);
thetaFDVector_Quasi_M06_M06               = interp1(timeVectorResults_Quasi_M06_M06', thetaFDVectorResults_Quasi_M06_M06', timeVector+initialTimeQuasi_M06_M06);

thetaKVector_Quasi_M06_M06                = interp1(timeVectorResults_Quasi_M06_M06', thetaKVectorResults_Quasi_M06_M06', timeVector+initialTimeQuasi_M06_M06);
thetaKDVector_Quasi_M06_M06               = interp1(timeVectorResults_Quasi_M06_M06', thetaKDVectorResults_Quasi_M06_M06', timeVector+initialTimeQuasi_M06_M06);

psiFVectorResults_Quasi_M06_M06      	= -results4QuasiActuators_M06_M06.psiF(timeVectorIds_Quasi_M06_M06);
psiFDVectorResults_Quasi_M06_M06     	= -results4QuasiActuators_M06_M06.psiF_d(timeVectorIds_Quasi_M06_M06);

psiKVectorResults_Quasi_M06_M06       	= -results4QuasiActuators_M06_M06.psiK(timeVectorIds_Quasi_M06_M06);
psiKDVectorResults_Quasi_M06_M06      	= -results4QuasiActuators_M06_M06.psiK_d(timeVectorIds_Quasi_M06_M06);

psiFVector_Quasi_M06_M06           	= interp1(timeVectorResults_Quasi_M06_M06', psiFVectorResults_Quasi_M06_M06', timeVector+initialTimeQuasi_M06_M06);
psiFDVector_Quasi_M06_M06              = interp1(timeVectorResults_Quasi_M06_M06', psiFDVectorResults_Quasi_M06_M06', timeVector+initialTimeQuasi_M06_M06);

psiKVector_Quasi_M06_M06            	= interp1(timeVectorResults_Quasi_M06_M06', psiKVectorResults_Quasi_M06_M06', timeVector+initialTimeQuasi_M06_M06);
psiKDVector_Quasi_M06_M06            	= interp1(timeVectorResults_Quasi_M06_M06', psiKDVectorResults_Quasi_M06_M06', timeVector+initialTimeQuasi_M06_M06);

%%

thetaFVectorResults_Quasi_M06_M10         = -results4QuasiActuators_M06_M10.thetaF(timeVectorIds_Quasi_M06_M10);
thetaFDVectorResults_Quasi_M06_M10        = -results4QuasiActuators_M06_M10.thetaF_d(timeVectorIds_Quasi_M06_M10);

thetaKVectorResults_Quasi_M06_M10         = -results4QuasiActuators_M06_M10.thetaK(timeVectorIds_Quasi_M06_M10);
thetaKDVectorResults_Quasi_M06_M10        = -results4QuasiActuators_M06_M10.thetaK_d(timeVectorIds_Quasi_M06_M10);

thetaFVector_Quasi_M06_M10                = interp1(timeVectorResults_Quasi_M06_M10', thetaFVectorResults_Quasi_M06_M10', timeVector+initialTimeQuasi_M06_M10);
thetaFDVector_Quasi_M06_M10               = interp1(timeVectorResults_Quasi_M06_M10', thetaFDVectorResults_Quasi_M06_M10', timeVector+initialTimeQuasi_M06_M10);

thetaKVector_Quasi_M06_M10                = interp1(timeVectorResults_Quasi_M06_M10', thetaKVectorResults_Quasi_M06_M10', timeVector+initialTimeQuasi_M06_M10);
thetaKDVector_Quasi_M06_M10               = interp1(timeVectorResults_Quasi_M06_M10', thetaKDVectorResults_Quasi_M06_M10', timeVector+initialTimeQuasi_M06_M10);

psiFVectorResults_Quasi_M06_M10      	= -results4QuasiActuators_M06_M10.psiF(timeVectorIds_Quasi_M06_M10);
psiFDVectorResults_Quasi_M06_M10     	= -results4QuasiActuators_M06_M10.psiF_d(timeVectorIds_Quasi_M06_M10);

psiKVectorResults_Quasi_M06_M10       	= -results4QuasiActuators_M06_M10.psiK(timeVectorIds_Quasi_M06_M10);
psiKDVectorResults_Quasi_M06_M10      	= -results4QuasiActuators_M06_M10.psiK_d(timeVectorIds_Quasi_M06_M10);

psiFVector_Quasi_M06_M10           	= interp1(timeVectorResults_Quasi_M06_M10', psiFVectorResults_Quasi_M06_M10', timeVector+initialTimeQuasi_M06_M10);
psiFDVector_Quasi_M06_M10              = interp1(timeVectorResults_Quasi_M06_M10', psiFDVectorResults_Quasi_M06_M10', timeVector+initialTimeQuasi_M06_M10);

psiKVector_Quasi_M06_M10            	= interp1(timeVectorResults_Quasi_M06_M10', psiKVectorResults_Quasi_M06_M10', timeVector+initialTimeQuasi_M06_M10);
psiKDVector_Quasi_M06_M10            	= interp1(timeVectorResults_Quasi_M06_M10', psiKDVectorResults_Quasi_M06_M10', timeVector+initialTimeQuasi_M06_M10);


%% Figures
close all
pOpts   = loadPlotOptions;

%% Comparison figure
%%% Quasi_M06_08 vs Quasi_M06_M06 robot plot
figureQuasi                     = pOpts.gFigure('Quasi_M06_08 vs Quasi_M06_M06 robot plot');
figureQuasi.Visible             = 'on';
figureQuasi.Position            = pOpts.figurePosition3;
tiledLayoutQuasi                = pOpts.gTiledLayout(figureQuasi, [4,1]);      
tiledLayoutQuasi.Title.String 	= 'Comparison of the quasi robot trajectories in defferent slopes';

% ThetaF
tileAxesQuasiThetaF               = pOpts.gTileAxes(tiledLayoutQuasi, 1, [1,1]);
tileAxesQuasiThetaF.XGrid          = 'on';
tileAxesQuasiThetaF.YGrid          = 'on';

tileAxesQuasiThetaF.XMinorGrid     = 'on';
tileAxesQuasiThetaF.YMinorGrid     = 'off';
tileAxesQuasiThetaF.XScale         = 'linear';
tileAxesQuasiThetaF.YScale         = 'linear';

tileAxesQuasiThetaF.YLabel.String  = sprintf(['θ_{F} [rad]']);

QuasiThetaFLegend               	= legend(tileAxesQuasiThetaF);
QuasiThetaFLegend.Location       	= 'best';

pFemoralQuasi_M06_08ThetaF                        = pOpts.gLine(tileAxesQuasiThetaF, timeVector, thetaFVector_Quasi_M06_08);
pFemoralQuasi_M06_08ThetaF.Color                  = [0,0,0];
QuasiThetaFLegend.String{end}    	= '+0.8 [deg]';

pFemoralQuasi_M06_M06ThetaF                        = pOpts.gLine(tileAxesQuasiThetaF, timeVector, thetaFVector_Quasi_M06_M06);
pFemoralQuasi_M06_M06ThetaF.Color                  = pOpts.LineColor(1,:);
QuasiThetaFLegend.String{end+1}  	= '';
QuasiThetaFLegend.String{end}    	= '-0.6 [deg]';
pFemoralQuasi_M06_M06ThetaF.LineStyle             = '--';

pFemoralQuasi_M06_M10ThetaF                        = pOpts.gLine(tileAxesQuasiThetaF, timeVector, thetaFVector_Quasi_M06_M10);
pFemoralQuasi_M06_M10ThetaF.Color                  = [1,0.5,0.5];
QuasiThetaFLegend.String{end+1}  	= '';
QuasiThetaFLegend.String{end}    	= '-1.0 [deg]';
pFemoralQuasi_M06_M10ThetaF.LineStyle             = '-.';


% PsiF
tileAxesQuasiPsiF               = pOpts.gTileAxes(tiledLayoutQuasi, 2, [1,1]);
tileAxesQuasiPsiF.XGrid          = 'on';
tileAxesQuasiPsiF.YGrid          = 'on';

tileAxesQuasiPsiF.XMinorGrid     = 'on';
tileAxesQuasiPsiF.YMinorGrid     = 'off';
tileAxesQuasiPsiF.XScale         = 'linear';
tileAxesQuasiPsiF.YScale         = 'linear';

tileAxesQuasiPsiF.YLabel.String  = sprintf(['θ_{Κ} [rad]']);

QuasiPsiFLegend               	= legend(tileAxesQuasiPsiF);
QuasiPsiFLegend.Location       	= 'best';

pFemoralQuasi_M06_08PsiF                        = pOpts.gLine(tileAxesQuasiPsiF, timeVector, psiFVector_Quasi_M06_08);
pFemoralQuasi_M06_08PsiF.Color                  = [0,0,0];
QuasiPsiFLegend.String{end}    	= '0.8 [deg]';

pFemoralQuasi_M06_M06PsiF                        = pOpts.gLine(tileAxesQuasiPsiF, timeVector, psiFVector_Quasi_M06_M06);
pFemoralQuasi_M06_M06PsiF.Color                  = pOpts.LineColor(1,:);
QuasiPsiFLegend.String{end+1}  	= '';
QuasiPsiFLegend.String{end}    	= '-0.6 [deg]';
pFemoralQuasi_M06_M06PsiF.LineStyle             = '--';

pFemoralQuasi_M06_M10PsiF                        = pOpts.gLine(tileAxesQuasiPsiF, timeVector, psiFVector_Quasi_M06_M10);
pFemoralQuasi_M06_M10PsiF.Color                  = [1,0.5,0.5];
QuasiPsiFLegend.String{end+1}  	= '';
QuasiPsiFLegend.String{end}    	= '-1.0 [deg]';
pFemoralQuasi_M06_M10PsiF.LineStyle             = '-.';


% ThetaK
tileAxesQuasiThetaK               = pOpts.gTileAxes(tiledLayoutQuasi, 3, [1,1]);
tileAxesQuasiThetaK.XGrid          = 'on';
tileAxesQuasiThetaK.YGrid          = 'on';

tileAxesQuasiThetaK.XMinorGrid     = 'on';
tileAxesQuasiThetaK.YMinorGrid     = 'off';
tileAxesQuasiThetaK.XScale         = 'linear';
tileAxesQuasiThetaK.YScale         = 'linear';

tileAxesQuasiThetaK.YLabel.String  = sprintf(['θ_{Κ} [rad]']);

QuasiThetaKLegend               	= legend(tileAxesQuasiThetaK);
QuasiThetaKLegend.Location       	= 'best';

pFemoralQuasi_M06_08ThetaK                        = pOpts.gLine(tileAxesQuasiThetaK, timeVector, thetaKVector_Quasi_M06_08);
pFemoralQuasi_M06_08ThetaK.Color                  = [0,0,0];
QuasiThetaKLegend.String{end}    	= '0.8 [deg]';

pFemoralQuasi_M06_M06ThetaK                        = pOpts.gLine(tileAxesQuasiThetaK, timeVector, thetaKVector_Quasi_M06_M06);
pFemoralQuasi_M06_M06ThetaK.Color                  = pOpts.LineColor(1,:);
QuasiThetaKLegend.String{end+1}  	= '';
QuasiThetaKLegend.String{end}    	= '-0.6 [deg]';
pFemoralQuasi_M06_M06ThetaK.LineStyle             = '--';

pFemoralQuasi_M06_M10ThetaK                        = pOpts.gLine(tileAxesQuasiThetaK, timeVector, thetaKVector_Quasi_M06_M10);
pFemoralQuasi_M06_M10ThetaK.Color                  = [1,0.5,0.5];
QuasiThetaKLegend.String{end+1}  	= '';
QuasiThetaKLegend.String{end}    	= '-1.0 [deg]';
pFemoralQuasi_M06_M10ThetaK.LineStyle             = '-.';


% PsiK
tileAxesQuasiPsiK               = pOpts.gTileAxes(tiledLayoutQuasi, 4, [1,1]);
tileAxesQuasiPsiK.XGrid          = 'on';
tileAxesQuasiPsiK.YGrid          = 'on';

tileAxesQuasiPsiK.XMinorGrid     = 'on';
tileAxesQuasiPsiK.YMinorGrid     = 'off';
tileAxesQuasiPsiK.XScale         = 'linear';
tileAxesQuasiPsiK.YScale         = 'linear';

tileAxesQuasiPsiK.XLabel.String  = 'Time [sec]';
tileAxesQuasiPsiK.YLabel.String  = sprintf(['Ψ_{Κ} [rad]']);

QuasiPsiKLegend               	= legend(tileAxesQuasiPsiK);
QuasiPsiKLegend.Location       	= 'best';

pFemoralQuasi_M06_08PsiK                        = pOpts.gLine(tileAxesQuasiPsiK, timeVector, psiKVector_Quasi_M06_08);
pFemoralQuasi_M06_08PsiK.Color                  = [0,0,0];
QuasiPsiKLegend.String{end}    	= '0.8 [deg]';

pFemoralQuasi_M06_M06PsiK                        = pOpts.gLine(tileAxesQuasiPsiK, timeVector, psiKVector_Quasi_M06_M06);
pFemoralQuasi_M06_M06PsiK.Color                  = pOpts.LineColor(1,:);
QuasiPsiKLegend.String{end+1}  	= '';
QuasiPsiKLegend.String{end}    	= '-0.6 [deg]';
pFemoralQuasi_M06_M06PsiK.LineStyle             = '--';

pFemoralQuasi_M06_M10PsiK                        = pOpts.gLine(tileAxesQuasiPsiK, timeVector, psiKVector_Quasi_M06_M10);
pFemoralQuasi_M06_M10PsiK.Color                  = [1,0.5,0.5];
QuasiPsiKLegend.String{end+1}  	= '';
QuasiPsiKLegend.String{end}    	= '-1.0 [deg]';
pFemoralQuasi_M06_M10PsiK.LineStyle             = '-.';

