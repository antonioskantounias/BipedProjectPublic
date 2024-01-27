clear all
%% Initial data
numOfDUdata = 500;

%% Load the joint resuls from simulation
iIn_M06_00 = 1143;
iFin_M06_00 = 2591;

iIn_M06_06 = 1091;
iFin_M06_06 = 2599;

iIn_M07_00 = 12520;
iFin_M07_00 = 13942;

iIn_M08_00 = 12274;
iFin_M08_00 = 13669;

iIn_M06_07 = 12956;
iFin_M06_07 = 14408;

iIn_M06_08 = 12855;
iFin_M06_08 = 14353;

load('results4Actuators_M06_00.mat')
load('results4Actuators_M07_00.mat')
load('results4Actuators_M08_00.mat')
load('results4Actuators_M06_06.mat')
load('results4Actuators_M06_07.mat')
load('results4Actuators_M06_08.mat')

[timeVectorResults_M06_00,timeVectorIds_M06_00]  	= unique(sort( results4Actuators_M06_00.t(iIn_M06_00:iFin_M06_00) ));

thetaFVectorResults_M06_00         = -results4Actuators_M06_00.thetaF(timeVectorIds_M06_00);
thetaFDVectorResults_M06_00        = -results4Actuators_M06_00.thetaF_d(timeVectorIds_M06_00);
torqueThetaFVectorResults_M06_00   = -results4Actuators_M06_00.torqueThetaF(timeVectorIds_M06_00);

thetaKVectorResults_M06_00         = -results4Actuators_M06_00.thetaK(timeVectorIds_M06_00);
thetaKDVectorResults_M06_00        = -results4Actuators_M06_00.thetaK_d(timeVectorIds_M06_00);
torqueThetaKVectorResults_M06_00   = -results4Actuators_M06_00.torqueThetaK(timeVectorIds_M06_00);

timeVector_M06_00                  = linspace(timeVectorResults_M06_00(1),timeVectorResults_M06_00(end),numOfDUdata);
thetaFVector_M06_00                = interp1(timeVectorResults_M06_00', thetaFVectorResults_M06_00', timeVector_M06_00);
thetaFDVector_M06_00               = interp1(timeVectorResults_M06_00', thetaFDVectorResults_M06_00', timeVector_M06_00);
torqueThetaFVector_M06_00          = interp1(timeVectorResults_M06_00', torqueThetaFVectorResults_M06_00', timeVector_M06_00);

thetaKVector_M06_00                = interp1(timeVectorResults_M06_00', thetaKVectorResults_M06_00', timeVector_M06_00);
thetaKDVector_M06_00               = interp1(timeVectorResults_M06_00', thetaKDVectorResults_M06_00', timeVector_M06_00);
torqueThetaKVector_M06_00          = interp1(timeVectorResults_M06_00', torqueThetaKVectorResults_M06_00', timeVector_M06_00);

psiFVectorResults_M06_00      	= -results4Actuators_M06_00.psiF(timeVectorIds_M06_00);
psiFDVectorResults_M06_00     	= -results4Actuators_M06_00.psiF_d(timeVectorIds_M06_00);
torquePsiFVectorResults_M06_00 	= -results4Actuators_M06_00.torquePsiF(timeVectorIds_M06_00);

psiKVectorResults_M06_00       	= -results4Actuators_M06_00.psiK(timeVectorIds_M06_00);
psiKDVectorResults_M06_00      	= -results4Actuators_M06_00.psiK_d(timeVectorIds_M06_00);
torquePsiKVectorResults_M06_00 	= -results4Actuators_M06_00.torquePsiK(timeVectorIds_M06_00);

timeVector_M06_00           	= linspace(timeVectorResults_M06_00(1),timeVectorResults_M06_00(end),numOfDUdata);
psiFVector_M06_00           	= interp1(timeVectorResults_M06_00', psiFVectorResults_M06_00', timeVector_M06_00);
psiFDVector_M06_00              = interp1(timeVectorResults_M06_00', psiFDVectorResults_M06_00', timeVector_M06_00);
torquePsiFVector_M06_00       	= interp1(timeVectorResults_M06_00', torquePsiFVectorResults_M06_00', timeVector_M06_00);

psiKVector_M06_00            	= interp1(timeVectorResults_M06_00', psiKVectorResults_M06_00', timeVector_M06_00);
psiKDVector_M06_00            	= interp1(timeVectorResults_M06_00', psiKDVectorResults_M06_00', timeVector_M06_00);
torquePsiKVector_M06_00       	= interp1(timeVectorResults_M06_00', torquePsiKVectorResults_M06_00', timeVector_M06_00);


[timeVectorResults_M07_00,timeVectorIds_M07_00]  	= unique(sort( results4Actuators_M07_00.t(iIn_M07_00:iFin_M07_00) ));

thetaFVectorResults_M07_00         = -results4Actuators_M07_00.thetaF(timeVectorIds_M07_00);
thetaFDVectorResults_M07_00        = -results4Actuators_M07_00.thetaF_d(timeVectorIds_M07_00);
torqueThetaFVectorResults_M07_00   = -results4Actuators_M07_00.torqueThetaF(timeVectorIds_M07_00);

thetaKVectorResults_M07_00         = -results4Actuators_M07_00.thetaK(timeVectorIds_M07_00);
thetaKDVectorResults_M07_00        = -results4Actuators_M07_00.thetaK_d(timeVectorIds_M07_00);
torqueThetaKVectorResults_M07_00   = -results4Actuators_M07_00.torqueThetaK(timeVectorIds_M07_00);

timeVector_M07_00                  = linspace(timeVectorResults_M07_00(1),timeVectorResults_M07_00(end),numOfDUdata);
thetaFVector_M07_00                = interp1(timeVectorResults_M07_00', thetaFVectorResults_M07_00', timeVector_M07_00);
thetaFDVector_M07_00               = interp1(timeVectorResults_M07_00', thetaFDVectorResults_M07_00', timeVector_M07_00);
torqueThetaFVector_M07_00          = interp1(timeVectorResults_M07_00', torqueThetaFVectorResults_M07_00', timeVector_M07_00);

thetaKVector_M07_00                = interp1(timeVectorResults_M07_00', thetaKVectorResults_M07_00', timeVector_M07_00);
thetaKDVector_M07_00               = interp1(timeVectorResults_M07_00', thetaKDVectorResults_M07_00', timeVector_M07_00);
torqueThetaKVector_M07_00          = interp1(timeVectorResults_M07_00', torqueThetaKVectorResults_M07_00', timeVector_M07_00);

psiFVectorResults_M07_00         = -results4Actuators_M07_00.psiF(timeVectorIds_M07_00);
psiFDVectorResults_M07_00        = -results4Actuators_M07_00.psiF_d(timeVectorIds_M07_00);
torquePsiFVectorResults_M07_00   = -results4Actuators_M07_00.torquePsiF(timeVectorIds_M07_00);

psiKVectorResults_M07_00         = -results4Actuators_M07_00.psiK(timeVectorIds_M07_00);
psiKDVectorResults_M07_00        = -results4Actuators_M07_00.psiK_d(timeVectorIds_M07_00);
torquePsiKVectorResults_M07_00   = -results4Actuators_M07_00.torquePsiK(timeVectorIds_M07_00);

timeVector_M07_00                  = linspace(timeVectorResults_M07_00(1),timeVectorResults_M07_00(end),numOfDUdata);
psiFVector_M07_00                = interp1(timeVectorResults_M07_00', psiFVectorResults_M07_00', timeVector_M07_00);
psiFDVector_M07_00               = interp1(timeVectorResults_M07_00', psiFDVectorResults_M07_00', timeVector_M07_00);
torquePsiFVector_M07_00          = interp1(timeVectorResults_M07_00', torquePsiFVectorResults_M07_00', timeVector_M07_00);

psiKVector_M07_00                = interp1(timeVectorResults_M07_00', psiKVectorResults_M07_00', timeVector_M07_00);
psiKDVector_M07_00               = interp1(timeVectorResults_M07_00', psiKDVectorResults_M07_00', timeVector_M07_00);
torquePsiKVector_M07_00          = interp1(timeVectorResults_M07_00', torquePsiKVectorResults_M07_00', timeVector_M07_00);


[timeVectorResults_M08_00,timeVectorIds_M08_00]  	= unique(sort( results4Actuators_M08_00.t(iIn_M08_00:iFin_M08_00) ));

thetaFVectorResults_M08_00         = -results4Actuators_M08_00.thetaF(timeVectorIds_M08_00);
thetaFDVectorResults_M08_00        = -results4Actuators_M08_00.thetaF_d(timeVectorIds_M08_00);
torqueThetaFVectorResults_M08_00   = -results4Actuators_M08_00.torqueThetaF(timeVectorIds_M08_00);

thetaKVectorResults_M08_00         = -results4Actuators_M08_00.thetaK(timeVectorIds_M08_00);
thetaKDVectorResults_M08_00        = -results4Actuators_M08_00.thetaK_d(timeVectorIds_M08_00);
torqueThetaKVectorResults_M08_00   = -results4Actuators_M08_00.torqueThetaK(timeVectorIds_M08_00);

timeVector_M08_00                  = linspace(timeVectorResults_M08_00(1),timeVectorResults_M08_00(end),numOfDUdata);
thetaFVector_M08_00                = interp1(timeVectorResults_M08_00', thetaFVectorResults_M08_00', timeVector_M08_00);
thetaFDVector_M08_00               = interp1(timeVectorResults_M08_00', thetaFDVectorResults_M08_00', timeVector_M08_00);
torqueThetaFVector_M08_00          = interp1(timeVectorResults_M08_00', torqueThetaFVectorResults_M08_00', timeVector_M08_00);

thetaKVector_M08_00                = interp1(timeVectorResults_M08_00', thetaKVectorResults_M08_00', timeVector_M08_00);
thetaKDVector_M08_00               = interp1(timeVectorResults_M08_00', thetaKDVectorResults_M08_00', timeVector_M08_00);
torqueThetaKVector_M08_00          = interp1(timeVectorResults_M08_00', torqueThetaKVectorResults_M08_00', timeVector_M08_00);

psiFVectorResults_M08_00         = -results4Actuators_M08_00.psiF(timeVectorIds_M08_00);
psiFDVectorResults_M08_00        = -results4Actuators_M08_00.psiF_d(timeVectorIds_M08_00);
torquePsiFVectorResults_M08_00   = -results4Actuators_M08_00.torquePsiF(timeVectorIds_M08_00);

psiKVectorResults_M08_00         = -results4Actuators_M08_00.psiK(timeVectorIds_M08_00);
psiKDVectorResults_M08_00        = -results4Actuators_M08_00.psiK_d(timeVectorIds_M08_00);
torquePsiKVectorResults_M08_00   = -results4Actuators_M08_00.torquePsiK(timeVectorIds_M08_00);

timeVector_M08_00                  = linspace(timeVectorResults_M08_00(1),timeVectorResults_M08_00(end),numOfDUdata);
psiFVector_M08_00                = interp1(timeVectorResults_M08_00', psiFVectorResults_M08_00', timeVector_M08_00);
psiFDVector_M08_00               = interp1(timeVectorResults_M08_00', psiFDVectorResults_M08_00', timeVector_M08_00);
torquePsiFVector_M08_00          = interp1(timeVectorResults_M08_00', torquePsiFVectorResults_M08_00', timeVector_M08_00);

psiKVector_M08_00                = interp1(timeVectorResults_M08_00', psiKVectorResults_M08_00', timeVector_M08_00);
psiKDVector_M08_00               = interp1(timeVectorResults_M08_00', psiKDVectorResults_M08_00', timeVector_M08_00);
torquePsiKVector_M08_00          = interp1(timeVectorResults_M08_00', torquePsiKVectorResults_M08_00', timeVector_M08_00);


[timeVectorResults_M06_06,timeVectorIds_M06_06]  	= unique(sort( results4Actuators_M06_06.t(iIn_M06_06:iFin_M06_06) ));

thetaFVectorResults_M06_06         = -results4Actuators_M06_06.thetaF(timeVectorIds_M06_06);
thetaFDVectorResults_M06_06        = -results4Actuators_M06_06.thetaF_d(timeVectorIds_M06_06);
torqueThetaFVectorResults_M06_06   = -results4Actuators_M06_06.torqueThetaF(timeVectorIds_M06_06);

thetaKVectorResults_M06_06         = -results4Actuators_M06_06.thetaK(timeVectorIds_M06_06);
thetaKDVectorResults_M06_06        = -results4Actuators_M06_06.thetaK_d(timeVectorIds_M06_06);
torqueThetaKVectorResults_M06_06   = -results4Actuators_M06_06.torqueThetaK(timeVectorIds_M06_06);

timeVector_M06_06                  = linspace(timeVectorResults_M06_06(1),timeVectorResults_M06_06(end),numOfDUdata);
thetaFVector_M06_06                = interp1(timeVectorResults_M06_06', thetaFVectorResults_M06_06', timeVector_M06_06);
thetaFDVector_M06_06               = interp1(timeVectorResults_M06_06', thetaFDVectorResults_M06_06', timeVector_M06_06);
torqueThetaFVector_M06_06          = interp1(timeVectorResults_M06_06', torqueThetaFVectorResults_M06_06', timeVector_M06_06);

thetaKVector_M06_06                = interp1(timeVectorResults_M06_06', thetaKVectorResults_M06_06', timeVector_M06_06);
thetaKDVector_M06_06               = interp1(timeVectorResults_M06_06', thetaKDVectorResults_M06_06', timeVector_M06_06);
torqueThetaKVector_M06_06          = interp1(timeVectorResults_M06_06', torqueThetaKVectorResults_M06_06', timeVector_M06_06);

psiFVectorResults_M06_06         = -results4Actuators_M06_06.psiF(timeVectorIds_M06_06);
psiFDVectorResults_M06_06        = -results4Actuators_M06_06.psiF_d(timeVectorIds_M06_06);
torquePsiFVectorResults_M06_06   = -results4Actuators_M06_06.torquePsiF(timeVectorIds_M06_06);

psiKVectorResults_M06_06         = -results4Actuators_M06_06.psiK(timeVectorIds_M06_06);
psiKDVectorResults_M06_06        = -results4Actuators_M06_06.psiK_d(timeVectorIds_M06_06);
torquePsiKVectorResults_M06_06   = -results4Actuators_M06_06.torquePsiK(timeVectorIds_M06_06);

timeVector_M06_06                  = linspace(timeVectorResults_M06_06(1),timeVectorResults_M06_06(end),numOfDUdata);
psiFVector_M06_06                = interp1(timeVectorResults_M06_06', psiFVectorResults_M06_06', timeVector_M06_06);
psiFDVector_M06_06               = interp1(timeVectorResults_M06_06', psiFDVectorResults_M06_06', timeVector_M06_06);
torquePsiFVector_M06_06          = interp1(timeVectorResults_M06_06', torquePsiFVectorResults_M06_06', timeVector_M06_06);

psiKVector_M06_06                = interp1(timeVectorResults_M06_06', psiKVectorResults_M06_06', timeVector_M06_06);
psiKDVector_M06_06               = interp1(timeVectorResults_M06_06', psiKDVectorResults_M06_06', timeVector_M06_06);
torquePsiKVector_M06_06          = interp1(timeVectorResults_M06_06', torquePsiKVectorResults_M06_06', timeVector_M06_06);


[timeVectorResults_M06_07,timeVectorIds_M06_07]  	= unique(sort( results4Actuators_M06_07.t(iIn_M06_07:iFin_M06_07) ));

thetaFVectorResults_M06_07         = -results4Actuators_M06_07.thetaF(timeVectorIds_M06_07);
thetaFDVectorResults_M06_07        = -results4Actuators_M06_07.thetaF_d(timeVectorIds_M06_07);
torqueThetaFVectorResults_M06_07   = -results4Actuators_M06_07.torqueThetaF(timeVectorIds_M06_07);

thetaKVectorResults_M06_07         = -results4Actuators_M06_07.thetaK(timeVectorIds_M06_07);
thetaKDVectorResults_M06_07        = -results4Actuators_M06_07.thetaK_d(timeVectorIds_M06_07);
torqueThetaKVectorResults_M06_07   = -results4Actuators_M06_07.torqueThetaK(timeVectorIds_M06_07);

timeVector_M06_07                  = linspace(timeVectorResults_M06_07(1),timeVectorResults_M06_07(end),numOfDUdata);
thetaFVector_M06_07                = interp1(timeVectorResults_M06_07', thetaFVectorResults_M06_07', timeVector_M06_07);
thetaFDVector_M06_07               = interp1(timeVectorResults_M06_07', thetaFDVectorResults_M06_07', timeVector_M06_07);
torqueThetaFVector_M06_07          = interp1(timeVectorResults_M06_07', torqueThetaFVectorResults_M06_07', timeVector_M06_07);

thetaKVector_M06_07                = interp1(timeVectorResults_M06_07', thetaKVectorResults_M06_07', timeVector_M06_07);
thetaKDVector_M06_07               = interp1(timeVectorResults_M06_07', thetaKDVectorResults_M06_07', timeVector_M06_07);
torqueThetaKVector_M06_07          = interp1(timeVectorResults_M06_07', torqueThetaKVectorResults_M06_07', timeVector_M06_07);

psiFVectorResults_M06_07         = -results4Actuators_M06_07.psiF(timeVectorIds_M06_07);
psiFDVectorResults_M06_07        = -results4Actuators_M06_07.psiF_d(timeVectorIds_M06_07);
torquePsiFVectorResults_M06_07   = -results4Actuators_M06_07.torquePsiF(timeVectorIds_M06_07);

psiKVectorResults_M06_07         = -results4Actuators_M06_07.psiK(timeVectorIds_M06_07);
psiKDVectorResults_M06_07        = -results4Actuators_M06_07.psiK_d(timeVectorIds_M06_07);
torquePsiKVectorResults_M06_07   = -results4Actuators_M06_07.torquePsiK(timeVectorIds_M06_07);

timeVector_M06_07                  = linspace(timeVectorResults_M06_07(1),timeVectorResults_M06_07(end),numOfDUdata);
psiFVector_M06_07                = interp1(timeVectorResults_M06_07', psiFVectorResults_M06_07', timeVector_M06_07);
psiFDVector_M06_07               = interp1(timeVectorResults_M06_07', psiFDVectorResults_M06_07', timeVector_M06_07);
torquePsiFVector_M06_07          = interp1(timeVectorResults_M06_07', torquePsiFVectorResults_M06_07', timeVector_M06_07);

psiKVector_M06_07                = interp1(timeVectorResults_M06_07', psiKVectorResults_M06_07', timeVector_M06_07);
psiKDVector_M06_07               = interp1(timeVectorResults_M06_07', psiKDVectorResults_M06_07', timeVector_M06_07);
torquePsiKVector_M06_07          = interp1(timeVectorResults_M06_07', torquePsiKVectorResults_M06_07', timeVector_M06_07);


[timeVectorResults_M06_08,timeVectorIds_M06_08]  	= unique(sort( results4Actuators_M06_08.t(iIn_M06_08:iFin_M06_08) ));

thetaFVectorResults_M06_08         = -results4Actuators_M06_08.thetaF(timeVectorIds_M06_08);
thetaFDVectorResults_M06_08        = -results4Actuators_M06_08.thetaF_d(timeVectorIds_M06_08);
torqueThetaFVectorResults_M06_08   = -results4Actuators_M06_08.torqueThetaF(timeVectorIds_M06_08);

thetaKVectorResults_M06_08         = -results4Actuators_M06_08.thetaK(timeVectorIds_M06_08);
thetaKDVectorResults_M06_08        = -results4Actuators_M06_08.thetaK_d(timeVectorIds_M06_08);
torqueThetaKVectorResults_M06_08   = -results4Actuators_M06_08.torqueThetaK(timeVectorIds_M06_08);

timeVector_M06_08                  = linspace(timeVectorResults_M06_08(1),timeVectorResults_M06_08(end),numOfDUdata);
thetaFVector_M06_08                = interp1(timeVectorResults_M06_08', thetaFVectorResults_M06_08', timeVector_M06_08);
thetaFDVector_M06_08               = interp1(timeVectorResults_M06_08', thetaFDVectorResults_M06_08', timeVector_M06_08);
torqueThetaFVector_M06_08          = interp1(timeVectorResults_M06_08', torqueThetaFVectorResults_M06_08', timeVector_M06_08);

thetaKVector_M06_08                = interp1(timeVectorResults_M06_08', thetaKVectorResults_M06_08', timeVector_M06_08);
thetaKDVector_M06_08               = interp1(timeVectorResults_M06_08', thetaKDVectorResults_M06_08', timeVector_M06_08);
torqueThetaKVector_M06_08          = interp1(timeVectorResults_M06_08', torqueThetaKVectorResults_M06_08', timeVector_M06_08);

psiFVectorResults_M06_08         = -results4Actuators_M06_08.psiF(timeVectorIds_M06_08);
psiFDVectorResults_M06_08        = -results4Actuators_M06_08.psiF_d(timeVectorIds_M06_08);
torquePsiFVectorResults_M06_08   = -results4Actuators_M06_08.torquePsiF(timeVectorIds_M06_08);

psiKVectorResults_M06_08         = -results4Actuators_M06_08.psiK(timeVectorIds_M06_08);
psiKDVectorResults_M06_08        = -results4Actuators_M06_08.psiK_d(timeVectorIds_M06_08);
torquePsiKVectorResults_M06_08   = -results4Actuators_M06_08.torquePsiK(timeVectorIds_M06_08);

timeVector_M06_08                  = linspace(timeVectorResults_M06_08(1),timeVectorResults_M06_08(end),numOfDUdata);
psiFVector_M06_08                = interp1(timeVectorResults_M06_08', psiFVectorResults_M06_08', timeVector_M06_08);
psiFDVector_M06_08               = interp1(timeVectorResults_M06_08', psiFDVectorResults_M06_08', timeVector_M06_08);
torquePsiFVector_M06_08          = interp1(timeVectorResults_M06_08', torquePsiFVectorResults_M06_08', timeVector_M06_08);

psiKVector_M06_08                = interp1(timeVectorResults_M06_08', psiKVectorResults_M06_08', timeVector_M06_08);
psiKDVector_M06_08               = interp1(timeVectorResults_M06_08', psiKDVectorResults_M06_08', timeVector_M06_08);
torquePsiKVector_M06_08          = interp1(timeVectorResults_M06_08', torquePsiKVectorResults_M06_08', timeVector_M06_08);

%% Motor cofiguration Tmotors-MN5006
% batteryVoltage                  = 22.2;%14.8; %[volt]
% kt                              = 1/(300/60*2*pi); % [Nm/A] 0.0318;
% resistancePhase2Phase           = 0.125; % [Ohm] 
% currentRated                    = 20; % [A]
% motorName                       = 'T-Motors MN5006 KV300';
% 
% kv          = 1/kt; % [rad/sec/volt]
% kvrpm       = kv*60/2/pi; % [rpm/volt]
% 
% speedMotorMax    = kv*batteryVoltage; %[rad/sec]
% speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
% currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
% torqueMotorVec   = kt*currentMotorVec; %[Nm]
% torqueMotorRated = kt*currentRated; %[Nm]
% torqueMotorReduction = 1;
% speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
% torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];

%% Motor cofiguration Tmotors-MN5008 KV170
batteryVoltage                  = 22.2;%14.8; %[volt]
kt                              = 0.056; % [Nm/A]
resistancePhase2Phase           = 0.270; % [Ohm] 
currentRated                    = 3; % [A]
currentMaximum                  = 15; % [A] (180 sec)
motorName                       = 'T-Motors MN5008 KV170';

kv          = 1/kt; % [rad/sec/volt]
kvrpm       = kv*60/2/pi; % [rpm/volt]

speedMotorMax    = kv*batteryVoltage; %[rad/sec]
speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
torqueMotorVec   = kt*currentMotorVec; %[Nm]
torqueMotorRated = kt*currentRated; %[Nm]
torqueMotorMaximum = kt*currentMaximum; %[Nm]
torqueMotorReduction = 1;
speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];

%% Motor cofiguration 3863H 024CR  *****
% batteryVoltage                  = 22.2;%14.8; %[volt]
% kt                              = 0.0398; % [Nm/A]
% resistancePhase2Phase           = 0.64; % [Ohm] 
% currentRated                    = 4; % [A]
% motorName                       = '3863H 24CR';
% 
% kv          = 1/kt; % [rad/sec/volt]
% kvrpm       = kv*60/2/pi; % [rpm/volt]
% 
% speedMotorMax    = kv*batteryVoltage; %[rad/sec]
% speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
% currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
% torqueMotorVec   = kt*currentMotorVec; %[Nm]
% torqueMotorRated = kt*currentRated; %[Nm]
% torqueMotorReduction = 1;
% speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
% torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];

%% Motor cofiguration 3257H 024CR (FAULHABER)
% batteryVoltage                  = 22.2;%14.8; %[volt]
% kt                              = 0.0377; % [Nm/A]
% resistancePhase2Phase           = 1.63; % [Ohm] 
% currentRated                    = 2.3; % [A]
% motorName                       = '3257H 024CR';
% 
% kv          = 1/kt; % [rad/sec/volt]
% kvrpm       = kv*60/2/pi; % [rpm/volt]
% 
% speedMotorMax    = kv*batteryVoltage; %[rad/sec]
% speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
% currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
% torqueMotorVec   = kt*currentMotorVec; %[Nm]
% torqueMotorRated = kt*currentRated; %[Nm]
% torqueMotorReduction = 1;
% speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
% torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];

%% Motor cofiguration 3257H 024CR (FAULHABER) *****
% batteryVoltage                  = 22.2;%14.8; %[volt]
% kt                              = 0.0377; % [Nm/A]
% resistancePhase2Phase           = 1.63; % [Ohm] 
% currentRated                    = 2.3; % [A]
% motorName                       = '3257H 024CR';
% 
% kv          = 1/kt; % [rad/sec/volt]
% kvrpm       = kv*60/2/pi; % [rpm/volt]
% 
% speedMotorMax    = kv*batteryVoltage; %[rad/sec]
% speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
% currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
% torqueMotorVec   = kt*currentMotorVec; %[Nm]
% torqueMotorRated = kt*currentRated; %[Nm]
% torqueMotorReduction = 1;
% speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
% torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];


%% Motor cofiguration DC-max 26 S (Maxon)
% batteryVoltage                  = 22.2;%14.8; %[volt]
% kt                              = 0.0522; % [Nm/A]
% resistancePhase2Phase           = 9.08; % [Ohm] 
% currentRated                    = 0.562; % [A]
% motorName                       = 'DC-max 26 S';
% 
% kv          = 1/kt; % [rad/sec/volt]
% kvrpm       = kv*60/2/pi; % [rpm/volt]
% 
% speedMotorMax    = kv*batteryVoltage; %[rad/sec]
% speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
% currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
% torqueMotorVec   = kt*currentMotorVec; %[Nm]
% torqueMotorRated = kt*currentRated; %[Nm]
% torqueMotorReduction = 3.7;
% speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
% torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];


%% Motor cofiguration DCX 35 L Ø35 mm (Maxon) *****
% batteryVoltage                  = 22.2;%14.8; %[volt]
% kt                              = 0.0293; % [Nm/A]
% resistancePhase2Phase           = 0.346; % [Ohm] 
% currentRated                    = 4.26; % [A]
% motorName                       = 'DCX 35 L Ø35 mm';
% 
% kv          = 1/kt; % [rad/sec/volt]
% kvrpm       = kv*60/2/pi; % [rpm/volt]
% 
% speedMotorMax    = kv*batteryVoltage; %[rad/sec]
% speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
% currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
% torqueMotorVec   = kt*currentMotorVec; %[Nm]
% torqueMotorRated = kt*currentRated; %[Nm]
% torqueMotorReduction = 1;
% speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
% torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];

%% Motor cofiguration P-H500 (Jonshon Electric) ***
% batteryVoltage                  = 22.2;%14.8; %[volt]
% kt                              = 0.120/4.8; % [Nm/A]
% resistancePhase2Phase           = 13.5^2/4/42.36; % [Ohm] (Based on maximum pawer equation Pmax = U^2/4/R)
% currentRated                    = 4.8; % [A]
% motorName                       = 'P-H500';
% 
% kv          = 1/kt; % [rad/sec/volt]
% kvrpm       = kv*60/2/pi; % [rpm/volt]
% 
% speedMotorMax    = kv*batteryVoltage; %[rad/sec]
% speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
% currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
% torqueMotorVec   = kt*currentMotorVec; %[Nm]
% torqueMotorRated = kt*currentRated; %[Nm]
% torqueMotorReduction = 1;
% speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
% torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];

%% Motor cofiguration 35GLT2R82 326P (Portescap) *****
% batteryVoltage                  = 22.2;%14.8; %[volt]
% kt                              = 0.03910; % [Nm/A]
% resistancePhase2Phase           = 0.9; % [Ohm] (Based on maximum pawer equation Pmax = U^2/4/R)
% currentRated                    = 3.5; % [A]
% motorName                       = '35GLT2R82 326P';
% 
% kv          = 1/kt; % [rad/sec/volt]
% kvrpm       = kv*60/2/pi; % [rpm/volt]
% 
% speedMotorMax    = kv*batteryVoltage; %[rad/sec]
% speedMotorVec    = linspace(0,speedMotorMax,numOfDUdata); %[rad/sec]
% currentMotorVec  = (batteryVoltage - speedMotorVec/kv)/resistancePhase2Phase; %[A]
% torqueMotorVec   = kt*currentMotorVec; %[Nm]
% torqueMotorRated = kt*currentRated; %[Nm]
% torqueMotorReduction = 1;
% speedMotorVecTotal  = [speedMotorVec,rot90(speedMotorVec,2),-speedMotorVec,-rot90(speedMotorVec,2)];
% torqueMotorVecTotal = [torqueMotorVec,-rot90(torqueMotorVec,2),-torqueMotorVec,rot90(torqueMotorVec,2)];


%% Femoral Reduction ratio
PulleyPinion            = 12; %Teeth
PulleyGear              = 60*torqueMotorReduction; %Teeth
Motor2JointThetaFReduction_M06_00 	= PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointPsiFReduction_M06_00     = PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointThetaFReduction_M07_00 	= PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointPsiFReduction_M07_00     = PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointThetaFReduction_M08_00 	= PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointPsiFReduction_M08_00     = PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointThetaFReduction_M06_06 	= PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointPsiFReduction_M06_06     = PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointThetaFReduction_M06_07 	= PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointPsiFReduction_M06_07     = PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointThetaFReduction_M06_08 	= PulleyGear/PulleyPinion*ones(1,numOfDUdata);
Motor2JointPsiFReduction_M06_08     = PulleyGear/PulleyPinion*ones(1,numOfDUdata);

%% Femoral motor demand 
torqueMotorThetaFDemand_M06_00   = torqueThetaFVector_M06_00./Motor2JointThetaFReduction_M06_00;
currentMotorThetaFDemand_M06_00  = torqueMotorThetaFDemand_M06_00/kt;
currentRmsThetaFDemand_M06_00    = sqrt(array_int(currentMotorThetaFDemand_M06_00.^2,timeVector_M06_00,0)./(timeVector_M06_00-timeVector_M06_00(1)));
speedMotorThetaFDemand_M06_00    = thetaFDVector_M06_00.*Motor2JointThetaFReduction_M06_00;
powerThetaFDemand_M06_00         = torqueThetaFVector_M06_00.*thetaFDVector_M06_00;
powerThetaFDemandMax_M06_00      = max(powerThetaFDemand_M06_00);
 
torqueMotorThetaFDemand_M07_00   = torqueThetaFVector_M07_00./Motor2JointThetaFReduction_M07_00;
currentMotorThetaFDemand_M07_00  = torqueMotorThetaFDemand_M07_00/kt;
currentRmsThetaFDemand_M07_00    = sqrt(array_int(currentMotorThetaFDemand_M07_00.^2,timeVector_M07_00,0)./(timeVector_M07_00-timeVector_M07_00(1)));
speedMotorThetaFDemand_M07_00    = thetaFDVector_M07_00.*Motor2JointThetaFReduction_M07_00;
powerThetaFDemand_M07_00         = torqueThetaFVector_M07_00.*thetaFDVector_M07_00;
powerThetaFDemandMax_M07_00      = max(powerThetaFDemand_M07_00);

torqueMotorThetaFDemand_M08_00   = torqueThetaFVector_M08_00./Motor2JointThetaFReduction_M08_00;
currentMotorThetaFDemand_M08_00  = torqueMotorThetaFDemand_M08_00/kt;
currentRmsThetaFDemand_M08_00    = sqrt(array_int(currentMotorThetaFDemand_M08_00.^2,timeVector_M08_00,0)./(timeVector_M08_00-timeVector_M08_00(1)));
speedMotorThetaFDemand_M08_00    = thetaFDVector_M08_00.*Motor2JointThetaFReduction_M08_00;
powerThetaFDemand_M08_00         = torqueThetaFVector_M08_00.*thetaFDVector_M08_00;
powerThetaFDemandMax_M08_00      = max(powerThetaFDemand_M08_00);

torqueMotorThetaFDemand_M06_06   = torqueThetaFVector_M06_06./Motor2JointThetaFReduction_M06_06;
currentMotorThetaFDemand_M06_06  = torqueMotorThetaFDemand_M06_06/kt;
currentRmsThetaFDemand_M06_06    = sqrt(array_int(currentMotorThetaFDemand_M06_06.^2,timeVector_M06_06,0)./(timeVector_M06_06-timeVector_M06_06(1)));
speedMotorThetaFDemand_M06_06    = thetaFDVector_M06_06.*Motor2JointThetaFReduction_M06_06;
powerThetaFDemand_M06_06         = torqueThetaFVector_M06_06.*thetaFDVector_M06_06;
powerThetaFDemandMax_M06_06      = max(powerThetaFDemand_M06_06);

torqueMotorThetaFDemand_M06_07   = torqueThetaFVector_M06_07./Motor2JointThetaFReduction_M06_07;
currentMotorThetaFDemand_M06_07  = torqueMotorThetaFDemand_M06_07/kt;
currentRmsThetaFDemand_M06_07    = sqrt(array_int(currentMotorThetaFDemand_M06_07.^2,timeVector_M06_07,0)./(timeVector_M06_07-timeVector_M06_07(1)));
speedMotorThetaFDemand_M06_07    = thetaFDVector_M06_07.*Motor2JointThetaFReduction_M06_07;
powerThetaFDemand_M06_07         = torqueThetaFVector_M06_07.*thetaFDVector_M06_07;
powerThetaFDemandMax_M06_07      = max(powerThetaFDemand_M06_07);

torqueMotorThetaFDemand_M06_08   = torqueThetaFVector_M06_08./Motor2JointThetaFReduction_M06_08;
currentMotorThetaFDemand_M06_08  = torqueMotorThetaFDemand_M06_08/kt;
currentRmsThetaFDemand_M06_08    = sqrt(array_int(currentMotorThetaFDemand_M06_08.^2,timeVector_M06_08,0)./(timeVector_M06_08-timeVector_M06_08(1)));
speedMotorThetaFDemand_M06_08    = thetaFDVector_M06_08.*Motor2JointThetaFReduction_M06_08;
powerThetaFDemand_M06_08         = torqueThetaFVector_M06_08.*thetaFDVector_M06_08;
powerThetaFDemandMax_M06_08      = max(powerThetaFDemand_M06_08);

maxThetaFPower                    = max([powerThetaFDemandMax_M06_00,powerThetaFDemandMax_M07_00,powerThetaFDemandMax_M08_00,powerThetaFDemandMax_M06_06,powerThetaFDemandMax_M06_07,powerThetaFDemandMax_M06_08]);

torqueMotorPsiFDemand_M06_00   = torquePsiFVector_M06_00./Motor2JointPsiFReduction_M06_00;
currentMotorPsiFDemand_M06_00  = torqueMotorPsiFDemand_M06_00/kt;
currentRmsPsiFDemand_M06_00    = sqrt(array_int(currentMotorPsiFDemand_M06_00.^2,timeVector_M06_00,0)./(timeVector_M06_00-timeVector_M06_00(1)));
speedMotorPsiFDemand_M06_00    = psiFDVector_M06_00.*Motor2JointPsiFReduction_M06_00;
powerPsiFDemand_M06_00         = torquePsiFVector_M06_00.*psiFDVector_M06_00;
powerPsiFDemandMax_M06_00      = max(powerPsiFDemand_M06_00);
 
torqueMotorPsiFDemand_M07_00   = torquePsiFVector_M07_00./Motor2JointPsiFReduction_M07_00;
currentMotorPsiFDemand_M07_00  = torqueMotorPsiFDemand_M07_00/kt;
currentRmsPsiFDemand_M07_00    = sqrt(array_int(currentMotorPsiFDemand_M07_00.^2,timeVector_M07_00,0)./(timeVector_M07_00-timeVector_M07_00(1)));
speedMotorPsiFDemand_M07_00    = psiFDVector_M07_00.*Motor2JointPsiFReduction_M07_00;
powerPsiFDemand_M07_00         = torquePsiFVector_M07_00.*psiFDVector_M07_00;
powerPsiFDemandMax_M07_00      = max(powerPsiFDemand_M07_00);

torqueMotorPsiFDemand_M08_00   = torquePsiFVector_M08_00./Motor2JointPsiFReduction_M08_00;
currentMotorPsiFDemand_M08_00  = torqueMotorPsiFDemand_M08_00/kt;
currentRmsPsiFDemand_M08_00    = sqrt(array_int(currentMotorPsiFDemand_M08_00.^2,timeVector_M08_00,0)./(timeVector_M08_00-timeVector_M08_00(1)));
speedMotorPsiFDemand_M08_00    = psiFDVector_M08_00.*Motor2JointPsiFReduction_M08_00;
powerPsiFDemand_M08_00         = torquePsiFVector_M08_00.*psiFDVector_M08_00;
powerPsiFDemandMax_M08_00      = max(powerPsiFDemand_M08_00);

torqueMotorPsiFDemand_M06_06   = torquePsiFVector_M06_06./Motor2JointPsiFReduction_M06_06;
currentMotorPsiFDemand_M06_06  = torqueMotorPsiFDemand_M06_06/kt;
currentRmsPsiFDemand_M06_06    = sqrt(array_int(currentMotorPsiFDemand_M06_06.^2,timeVector_M06_06,0)./(timeVector_M06_06-timeVector_M06_06(1)));
speedMotorPsiFDemand_M06_06    = psiFDVector_M06_06.*Motor2JointPsiFReduction_M06_06;
powerPsiFDemand_M06_06         = torquePsiFVector_M06_06.*psiFDVector_M06_06;
powerPsiFDemandMax_M06_06      = max(powerPsiFDemand_M06_06);

torqueMotorPsiFDemand_M06_07   = torquePsiFVector_M06_07./Motor2JointPsiFReduction_M06_07;
currentMotorPsiFDemand_M06_07  = torqueMotorPsiFDemand_M06_07/kt;
currentRmsPsiFDemand_M06_07    = sqrt(array_int(currentMotorPsiFDemand_M06_07.^2,timeVector_M06_07,0)./(timeVector_M06_07-timeVector_M06_07(1)));
speedMotorPsiFDemand_M06_07    = psiFDVector_M06_07.*Motor2JointPsiFReduction_M06_07;
powerPsiFDemand_M06_07         = torquePsiFVector_M06_07.*psiFDVector_M06_07;
powerPsiFDemandMax_M06_07      = max(powerPsiFDemand_M06_07);

torqueMotorPsiFDemand_M06_08   = torquePsiFVector_M06_08./Motor2JointPsiFReduction_M06_08;
currentMotorPsiFDemand_M06_08  = torqueMotorPsiFDemand_M06_08/kt;
currentRmsPsiFDemand_M06_08    = sqrt(array_int(currentMotorPsiFDemand_M06_08.^2,timeVector_M06_08,0)./(timeVector_M06_08-timeVector_M06_08(1)));
speedMotorPsiFDemand_M06_08    = psiFDVector_M06_08.*Motor2JointPsiFReduction_M06_08;
powerPsiFDemand_M06_08         = torquePsiFVector_M06_08.*psiFDVector_M06_08;
powerPsiFDemandMax_M06_08      = max(powerPsiFDemand_M06_08);

maxPsiFPower                    = max([powerPsiFDemandMax_M06_00,powerPsiFDemandMax_M07_00,powerPsiFDemandMax_M08_00,powerPsiFDemandMax_M06_06,powerPsiFDemandMax_M06_07,powerPsiFDemandMax_M06_08]);

%% Knee Reduction ration
a = 0.5;
b = 0.15;
f = 1.2684;
g = 1;
thetaOffset = 1.6;

Motor2JointThetaKReduction_M06_00  = dpsiFB_dthFB(a,b,f,g,thetaOffset+thetaKVector_M06_00);
Motor2JointThetaKReduction_M07_00  = dpsiFB_dthFB(a,b,f,g,thetaOffset+thetaKVector_M07_00);
Motor2JointThetaKReduction_M08_00  = dpsiFB_dthFB(a,b,f,g,thetaOffset+thetaKVector_M08_00);
Motor2JointThetaKReduction_M06_06  = dpsiFB_dthFB(a,b,f,g,thetaOffset+thetaKVector_M06_06);
Motor2JointThetaKReduction_M06_07  = dpsiFB_dthFB(a,b,f,g,thetaOffset+thetaKVector_M06_07);
Motor2JointThetaKReduction_M06_08  = dpsiFB_dthFB(a,b,f,g,thetaOffset+thetaKVector_M06_08);

Motor2JointPsiKReduction_M06_00  = dpsiFB_dthFB(a,b,f,g,thetaOffset+psiKVector_M06_00);
Motor2JointPsiKReduction_M07_00  = dpsiFB_dthFB(a,b,f,g,thetaOffset+psiKVector_M07_00);
Motor2JointPsiKReduction_M08_00  = dpsiFB_dthFB(a,b,f,g,thetaOffset+psiKVector_M08_00);
Motor2JointPsiKReduction_M06_06  = dpsiFB_dthFB(a,b,f,g,thetaOffset+psiKVector_M06_06);
Motor2JointPsiKReduction_M06_07  = dpsiFB_dthFB(a,b,f,g,thetaOffset+psiKVector_M06_07);
Motor2JointPsiKReduction_M06_08  = dpsiFB_dthFB(a,b,f,g,thetaOffset+psiKVector_M06_08);

%% Knee motor demand 
torqueMotorThetaKDemand_M06_00   = torqueThetaKVector_M06_00./Motor2JointThetaKReduction_M06_00;
currentMotorThetaKDemand_M06_00  = torqueMotorThetaKDemand_M06_00/kt;
currentRmsThetaKDemand_M06_00    = sqrt(array_int(currentMotorThetaKDemand_M06_00.^2,timeVector_M06_00,0)./(timeVector_M06_00-timeVector_M06_00(1)));
speedMotorThetaKDemand_M06_00    = thetaKDVector_M06_00.*Motor2JointThetaKReduction_M06_00;
powerThetaKDemand_M06_00         = torqueThetaKVector_M06_00.*thetaKDVector_M06_00;
powerThetaKDemandMax_M06_00      = max(powerThetaKDemand_M06_00);

torqueMotorThetaKDemand_M07_00   = torqueThetaKVector_M07_00./Motor2JointThetaKReduction_M07_00;
currentMotorThetaKDemand_M07_00  = torqueMotorThetaKDemand_M07_00/kt;
currentRmsThetaKDemand_M07_00    = sqrt(array_int(currentMotorThetaKDemand_M07_00.^2,timeVector_M07_00,0)./(timeVector_M07_00-timeVector_M07_00(1)));
speedMotorThetaKDemand_M07_00    = thetaKDVector_M07_00.*Motor2JointThetaKReduction_M07_00;
powerThetaKDemand_M07_00         = torqueThetaKVector_M07_00.*thetaKDVector_M07_00;
powerThetaKDemandMax_M07_00      = max(powerThetaKDemand_M07_00);

torqueMotorThetaKDemand_M08_00   = torqueThetaKVector_M08_00./Motor2JointThetaKReduction_M08_00;
currentMotorThetaKDemand_M08_00  = torqueMotorThetaKDemand_M08_00/kt;
currentRmsThetaKDemand_M08_00    = sqrt(array_int(currentMotorThetaKDemand_M08_00.^2,timeVector_M08_00,0)./(timeVector_M08_00-timeVector_M08_00(1)));
speedMotorThetaKDemand_M08_00    = thetaKDVector_M08_00.*Motor2JointThetaKReduction_M08_00;
powerThetaKDemand_M08_00         = torqueThetaKVector_M08_00.*thetaKDVector_M08_00;
powerThetaKDemandMax_M08_00      = max(powerThetaKDemand_M08_00);

torqueMotorThetaKDemand_M06_06   = torqueThetaKVector_M06_06./Motor2JointThetaKReduction_M06_06;
currentMotorThetaKDemand_M06_06  = torqueMotorThetaKDemand_M06_06/kt;
currentRmsThetaKDemand_M06_06    = sqrt(array_int(currentMotorThetaKDemand_M06_06.^2,timeVector_M06_06,0)./(timeVector_M06_06-timeVector_M06_06(1)));
speedMotorThetaKDemand_M06_06    = thetaKDVector_M06_06.*Motor2JointThetaKReduction_M06_06;
powerThetaKDemand_M06_06         = torqueThetaKVector_M06_06.*thetaKDVector_M06_06;
powerThetaKDemandMax_M06_06      = max(powerThetaKDemand_M06_06);

torqueMotorThetaKDemand_M06_07   = torqueThetaKVector_M06_07./Motor2JointThetaKReduction_M06_07;
currentMotorThetaKDemand_M06_07  = torqueMotorThetaKDemand_M06_07/kt;
currentRmsThetaKDemand_M06_07    = sqrt(array_int(currentMotorThetaKDemand_M06_07.^2,timeVector_M06_07,0)./(timeVector_M06_07-timeVector_M06_07(1)));
speedMotorThetaKDemand_M06_07    = thetaKDVector_M06_07.*Motor2JointThetaKReduction_M06_07;
powerThetaKDemand_M06_07         = torqueThetaKVector_M06_07.*thetaKDVector_M06_07;
powerThetaKDemandMax_M06_07      = max(powerThetaKDemand_M06_07);

torqueMotorThetaKDemand_M06_08   = torqueThetaKVector_M06_08./Motor2JointThetaKReduction_M06_08;
currentMotorThetaKDemand_M06_08  = torqueMotorThetaKDemand_M06_08/kt;
currentRmsThetaKDemand_M06_08    = sqrt(array_int(currentMotorThetaKDemand_M06_08.^2,timeVector_M06_08,0)./(timeVector_M06_08-timeVector_M06_08(1)));
speedMotorThetaKDemand_M06_08    = thetaKDVector_M06_08.*Motor2JointThetaKReduction_M06_08;
powerThetaKDemand_M06_08         = torqueThetaKVector_M06_08.*thetaKDVector_M06_08;
powerThetaKDemandMax_M06_08      = max(powerThetaKDemand_M06_08);

maxThetaKPower                    = max([powerThetaKDemandMax_M06_00,powerThetaKDemandMax_M07_00,powerThetaKDemandMax_M08_00,powerThetaKDemandMax_M06_06,powerThetaKDemandMax_M06_07,powerThetaKDemandMax_M06_08]);

torqueMotorPsiKDemand_M06_00   = torquePsiKVector_M06_00./Motor2JointPsiKReduction_M06_00;
currentMotorPsiKDemand_M06_00  = torqueMotorPsiKDemand_M06_00/kt;
currentRmsPsiKDemand_M06_00    = sqrt(array_int(currentMotorPsiKDemand_M06_00.^2,timeVector_M06_00,0)./(timeVector_M06_00-timeVector_M06_00(1)));
speedMotorPsiKDemand_M06_00    = psiKDVector_M06_00.*Motor2JointPsiKReduction_M06_00;
powerPsiKDemand_M06_00         = torquePsiKVector_M06_00.*psiKDVector_M06_00;
powerPsiKDemandMax_M06_00      = max(powerPsiKDemand_M06_00);

torqueMotorPsiKDemand_M07_00   = torquePsiKVector_M07_00./Motor2JointPsiKReduction_M07_00;
currentMotorPsiKDemand_M07_00  = torqueMotorPsiKDemand_M07_00/kt;
currentRmsPsiKDemand_M07_00    = sqrt(array_int(currentMotorPsiKDemand_M07_00.^2,timeVector_M07_00,0)./(timeVector_M07_00-timeVector_M07_00(1)));
speedMotorPsiKDemand_M07_00    = psiKDVector_M07_00.*Motor2JointPsiKReduction_M07_00;
powerPsiKDemand_M07_00         = torquePsiKVector_M07_00.*psiKDVector_M07_00;
powerPsiKDemandMax_M07_00      = max(powerPsiKDemand_M07_00);

torqueMotorPsiKDemand_M08_00   = torquePsiKVector_M08_00./Motor2JointPsiKReduction_M08_00;
currentMotorPsiKDemand_M08_00  = torqueMotorPsiKDemand_M08_00/kt;
currentRmsPsiKDemand_M08_00    = sqrt(array_int(currentMotorPsiKDemand_M08_00.^2,timeVector_M08_00,0)./(timeVector_M08_00-timeVector_M08_00(1)));
speedMotorPsiKDemand_M08_00    = psiKDVector_M08_00.*Motor2JointPsiKReduction_M08_00;
powerPsiKDemand_M08_00         = torquePsiKVector_M08_00.*psiKDVector_M08_00;
powerPsiKDemandMax_M08_00      = max(powerPsiKDemand_M08_00);

torqueMotorPsiKDemand_M06_06   = torquePsiKVector_M06_06./Motor2JointPsiKReduction_M06_06;
currentMotorPsiKDemand_M06_06  = torqueMotorPsiKDemand_M06_06/kt;
currentRmsPsiKDemand_M06_06    = sqrt(array_int(currentMotorPsiKDemand_M06_06.^2,timeVector_M06_06,0)./(timeVector_M06_06-timeVector_M06_06(1)));
speedMotorPsiKDemand_M06_06    = psiKDVector_M06_06.*Motor2JointPsiKReduction_M06_06;
powerPsiKDemand_M06_06         = torquePsiKVector_M06_06.*psiKDVector_M06_06;
powerPsiKDemandMax_M06_06      = max(powerPsiKDemand_M06_06);

torqueMotorPsiKDemand_M06_07   = torquePsiKVector_M06_07./Motor2JointPsiKReduction_M06_07;
currentMotorPsiKDemand_M06_07  = torqueMotorPsiKDemand_M06_07/kt;
currentRmsPsiKDemand_M06_07    = sqrt(array_int(currentMotorPsiKDemand_M06_07.^2,timeVector_M06_07,0)./(timeVector_M06_07-timeVector_M06_07(1)));
speedMotorPsiKDemand_M06_07    = psiKDVector_M06_07.*Motor2JointPsiKReduction_M06_07;
powerPsiKDemand_M06_07         = torquePsiKVector_M06_07.*psiKDVector_M06_07;
powerPsiKDemandMax_M06_07      = max(powerPsiKDemand_M06_07);

torqueMotorPsiKDemand_M06_08   = torquePsiKVector_M06_08./Motor2JointPsiKReduction_M06_08;
currentMotorPsiKDemand_M06_08  = torqueMotorPsiKDemand_M06_08/kt;
currentRmsPsiKDemand_M06_08    = sqrt(array_int(currentMotorPsiKDemand_M06_08.^2,timeVector_M06_08,0)./(timeVector_M06_08-timeVector_M06_08(1)));
speedMotorPsiKDemand_M06_08    = psiKDVector_M06_08.*Motor2JointPsiKReduction_M06_08;
powerPsiKDemand_M06_08         = torquePsiKVector_M06_08.*psiKDVector_M06_08;
powerPsiKDemandMax_M06_08      = max(powerPsiKDemand_M06_08);

maxPsiKPower                    = max([powerPsiKDemandMax_M06_00,powerPsiKDemandMax_M07_00,powerPsiKDemandMax_M08_00,powerPsiKDemandMax_M06_06,powerPsiKDemandMax_M06_07,powerPsiKDemandMax_M06_08]);

%% Electrical power demand
powerThetaFElDemand_M06_08   	= torqueMotorThetaFDemand_M06_08.^2/kt^2*resistancePhase2Phase + abs(torqueMotorThetaFDemand_M06_08.*speedMotorThetaFDemand_M06_08);
energyThetaFElDemand_M06_08   	= array_int(powerThetaFElDemand_M06_08,timeVector_M06_08,0);

powerPsiFElDemand_M06_08        = torqueMotorPsiFDemand_M06_08.^2/kt^2*resistancePhase2Phase + abs(torqueMotorPsiFDemand_M06_08.*speedMotorPsiFDemand_M06_08);
energyPsiFElDemand_M06_08     	= array_int(powerPsiFElDemand_M06_08,timeVector_M06_08,0);

powerThetaKElDemand_M06_08    	= torqueMotorThetaKDemand_M06_08.^2/kt^2*resistancePhase2Phase + abs(torqueMotorThetaKDemand_M06_08.*speedMotorThetaKDemand_M06_08);
energyThetaKElDemand_M06_08    	= array_int(powerThetaKElDemand_M06_08,timeVector_M06_08,0);

powerPsiKElDemand_M06_08        = torqueMotorPsiKDemand_M06_08.^2/kt^2*resistancePhase2Phase + abs(torqueMotorPsiKDemand_M06_08.*speedMotorPsiKDemand_M06_08);
energyPsiKElDemand_M06_08     	= array_int(powerPsiKElDemand_M06_08,timeVector_M06_08,0);

powerDemand_M06_08            	= powerThetaFDemand_M06_08 + powerPsiFDemand_M06_08 + powerThetaKDemand_M06_08 + powerPsiKDemand_M06_08;
powerElDemand_M06_08          	= powerThetaFElDemand_M06_08 + powerPsiFElDemand_M06_08 + powerThetaKElDemand_M06_08 + powerPsiKElDemand_M06_08;
energyElDemand_M06_08         	= energyThetaFElDemand_M06_08 + energyPsiFElDemand_M06_08 + energyThetaKElDemand_M06_08 + energyPsiKElDemand_M06_08;

%% Visualize the simulation results from actuators
close all
pOpts   = loadPlotOptions;

%%% Femoral figure
figureFemoralMotor              = pOpts.gFigure('Femoral Motor Torque Speed Plot');
% figureFemoralMotor.Position     = pOpts.figurePosition3;
figureFemoralMotor.Visible      = 'on';

axesFemoralMotor                = pOpts.gAxes(figureFemoralMotor);
axesFemoralMotor.XLim           = [-15,15];
axesFemoralMotor.YLim           = [-1,1];

axesFemoralMotor.XGrid          = 'off';
axesFemoralMotor.YGrid          = 'off';
axesFemoralMotor.XMinorGrid     = 'off';
axesFemoralMotor.YMinorGrid     = 'off';
axesFemoralMotor.XScale         = 'linear';
axesFemoralMotor.YScale         = 'linear';

axesFemoralMotor.Title.String   = sprintf(['Femoral Motor Torque - Speed Demand \nWith ',motorName]);
axesFemoralMotor.XLabel.String  = 'Speed [rad/sec]';
axesFemoralMotor.YLabel.String  = 'Torque [Nm]';

femoralMotorLegend = legend(axesFemoralMotor);
femoralMotorLegend.Location = 'best';%'southoutside';
% Battery maximum voltage
pFemoralMotorFill                   = pOpts.gFill(axesFemoralMotor,speedMotorVecTotal,torqueMotorVecTotal, 1);
femoralMotorLegend.String{end}      = 'Supply voltage limitation';

% Motor maximum current limit
pFemoralMotorTLimMaximumFill            = pOpts.gFill(axesFemoralMotor,[min(speedMotorVecTotal),max(speedMotorVecTotal),max(speedMotorVecTotal),min(speedMotorVecTotal)],[torqueMotorMaximum,torqueMotorMaximum,-torqueMotorMaximum,-torqueMotorMaximum], 3);
femoralMotorLegend.String{end+1}    = '';
femoralMotorLegend.String{end}    = 'Maximum current (180sec) limitation';

% Motor rated current limit
pFemoralMotorTLimMaxFill            = pOpts.gFill(axesFemoralMotor,[min(speedMotorVecTotal),max(speedMotorVecTotal),max(speedMotorVecTotal),min(speedMotorVecTotal)],[torqueMotorRated,torqueMotorRated,-torqueMotorRated,-torqueMotorRated], 2);
femoralMotorLegend.String{end+1}    = '';
femoralMotorLegend.String{end}    = 'Rated current limitation';

% Motor torque and speed demands
pFemoralMotorDemandLine_M06_00             = pOpts.gLine(axesFemoralMotor, speedMotorThetaFDemand_M06_00, torqueMotorThetaFDemand_M06_00);
pFemoralMotorDemandLine_M06_00.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(1,:);
pFemoralMotorDemandLine_M06_00.Annotation.LegendInformation.IconDisplayStyle = 'off';

pFemoralMotorDemandLine_M07_00             = pOpts.gLine(axesFemoralMotor, speedMotorThetaFDemand_M07_00, torqueMotorThetaFDemand_M07_00);
pFemoralMotorDemandLine_M07_00.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(2,:);
pFemoralMotorDemandLine_M07_00.Annotation.LegendInformation.IconDisplayStyle = 'off';

pFemoralMotorDemandLine_M08_00             = pOpts.gLine(axesFemoralMotor, speedMotorThetaFDemand_M08_00, torqueMotorThetaFDemand_M08_00);
pFemoralMotorDemandLine_M08_00.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(3,:);
pFemoralMotorDemandLine_M08_00.Annotation.LegendInformation.IconDisplayStyle = 'off';

pFemoralMotorDemandLine_M06_06             = pOpts.gLine(axesFemoralMotor, speedMotorThetaFDemand_M06_06, torqueMotorThetaFDemand_M06_06);
pFemoralMotorDemandLine_M06_06.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(4,:);
pFemoralMotorDemandLine_M06_06.Annotation.LegendInformation.IconDisplayStyle = 'off';

pFemoralMotorDemandLine_M06_07             = pOpts.gLine(axesFemoralMotor, speedMotorThetaFDemand_M06_07, torqueMotorThetaFDemand_M06_07);
pFemoralMotorDemandLine_M06_07.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(5,:);
femoralMotorLegend.String{end+1}    = '';
femoralMotorLegend.String{end}    = 'Other gait scenarios';

pFemoralMotorDemandLine_M06_08             = pOpts.gLine(axesFemoralMotor, speedMotorThetaFDemand_M06_08, torqueMotorThetaFDemand_M06_08);
pFemoralMotorDemandLine_M06_08.Color       = pOpts.LineColor(1,:);
femoralMotorLegend.String{end+1}    = '';
femoralMotorLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.8 deg';

%%% Knee figure
figureKneeMotor              = pOpts.gFigure('Knee Motor Torque Speed Plot');
figureKneeMotor.Visible      = 'on';

axesKneeMotor                = pOpts.gAxes(figureKneeMotor);
axesKneeMotor.XGrid          = 'off';
axesKneeMotor.YGrid          = 'off';
axesKneeMotor.XLim           = [-15,15];
axesKneeMotor.YLim           = [-1,1];
axesKneeMotor.XMinorGrid     = 'off';
axesKneeMotor.YMinorGrid     = 'off';
axesKneeMotor.XScale         = 'linear';
axesKneeMotor.YScale         = 'linear';

axesKneeMotor.Title.String   = sprintf(['Knee Motor Torque - Speed Demand \nWith ',motorName]);
axesKneeMotor.XLabel.String  = 'Speed [rad/sec]';
axesKneeMotor.YLabel.String  = 'Torque [Nm]';

kneeMotorLegend = legend(axesKneeMotor);
kneeMotorLegend.Location = 'best';

% Battery maximum voltage
pKneeMotorFill                   = pOpts.gFill(axesKneeMotor,speedMotorVecTotal,torqueMotorVecTotal, 1);
kneeMotorLegend.String{end}      = 'Supply voltage limitation';

% Motor maximum current limit
pKneeMotorTLimMaximumFill            = pOpts.gFill(axesKneeMotor,[min(speedMotorVecTotal),max(speedMotorVecTotal),max(speedMotorVecTotal),min(speedMotorVecTotal)],[torqueMotorMaximum,torqueMotorMaximum,-torqueMotorMaximum,-torqueMotorMaximum], 3);
kneeMotorLegend.String{end+1}    = '';
kneeMotorLegend.String{end}    = 'Maximum current (180sec) limitation';

% Motor rated current limit
pKneeMotorTLimRatedFill            = pOpts.gFill(axesKneeMotor,[min(speedMotorVecTotal),max(speedMotorVecTotal),max(speedMotorVecTotal),min(speedMotorVecTotal)],[torqueMotorRated,torqueMotorRated,-torqueMotorRated,-torqueMotorRated], 2);
kneeMotorLegend.String{end+1}    = '';
kneeMotorLegend.String{end}    = 'Rated current limitation';

% Motor torque and speed demands
pKneeMotorDemandLine_M06_00             = pOpts.gLine(axesKneeMotor, speedMotorThetaKDemand_M06_00, torqueMotorThetaKDemand_M06_00);
pKneeMotorDemandLine_M06_00.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(1,:);
pKneeMotorDemandLine_M06_00.Annotation.LegendInformation.IconDisplayStyle = 'off';

pKneeMotorDemandLine_M07_00             = pOpts.gLine(axesKneeMotor, speedMotorThetaKDemand_M07_00, torqueMotorThetaKDemand_M07_00);
pKneeMotorDemandLine_M07_00.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(2,:);
pKneeMotorDemandLine_M07_00.Annotation.LegendInformation.IconDisplayStyle = 'off';

pKneeMotorDemandLine_M08_00             = pOpts.gLine(axesKneeMotor, speedMotorThetaKDemand_M08_00, torqueMotorThetaKDemand_M08_00);
pKneeMotorDemandLine_M08_00.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(3,:);
pKneeMotorDemandLine_M08_00.Annotation.LegendInformation.IconDisplayStyle = 'off';

pKneeMotorDemandLine_M06_06             = pOpts.gLine(axesKneeMotor, speedMotorThetaKDemand_M06_06, torqueMotorThetaKDemand_M06_06);
pKneeMotorDemandLine_M06_06.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(4,:);
pKneeMotorDemandLine_M06_06.Annotation.LegendInformation.IconDisplayStyle = 'off';

pKneeMotorDemandLine_M06_07             = pOpts.gLine(axesKneeMotor, speedMotorThetaKDemand_M06_07, torqueMotorThetaKDemand_M06_07);
pKneeMotorDemandLine_M06_07.Color       =  [0.2,0.2,0.2];%pOpts.LineColor(5,:);
kneeMotorLegend.String{end+1}    = '';
kneeMotorLegend.String{end}    = 'Other gait scenarios';

pKneeMotorDemandLine_M06_08             = pOpts.gLine(axesKneeMotor, speedMotorThetaKDemand_M06_08, torqueMotorThetaKDemand_M06_08);
pKneeMotorDemandLine_M06_08.Color       = pOpts.LineColor(1,:);
kneeMotorLegend.String{end+1}    = '';
kneeMotorLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.8 deg';


%%% Femoral joint torque-speed demand figure 
figureFemoral              = pOpts.gFigure('Femoral Joint Torque Speed Plot');
figureFemoral.Visible      = 'on';

axesFemoral                = pOpts.gAxes(figureFemoral);
axesFemoral.XGrid          = 'on';
axesFemoral.YGrid          = 'on';

axesFemoral.XMinorGrid     = 'on';
axesFemoral.YMinorGrid     = 'off';
axesFemoral.XScale         = 'linear';
axesFemoral.YScale         = 'linear';

axesFemoral.Title.String   = sprintf('Femoral Joint Torque - Speed Demand');
axesFemoral.XLabel.String  = 'Speed [rad/sec]';
axesFemoral.YLabel.String  = 'Torque [Nm]';

FemoralLegend = legend(axesFemoral);
FemoralLegend.Location = 'southoutside';

pFemoralDemandLine_M06_00             = pOpts.gLine(axesFemoral, thetaFDVector_M06_00, torqueThetaFVector_M06_00);
pFemoralDemandLine_M06_00.Color       = [0.5,0.5,0.5];%pOpts.LineColor(1,:);
FemoralLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.0 deg';

pFemoralDemandLine_M07_00             = pOpts.gLine(axesFemoral, thetaFDVector_M07_00, torqueThetaFVector_M07_00);
pFemoralDemandLine_M07_00.Color       = [0.5,0.5,0.5];% pOpts.LineColor(2,:);
FemoralLegend.String{end+1}    = '';
FemoralLegend.String{end}    = 'Compensation -0.7 deg with Slope 0.0 deg';

pFemoralDemandLine_M08_00             = pOpts.gLine(axesFemoral, thetaFDVector_M08_00, torqueThetaFVector_M08_00);
pFemoralDemandLine_M08_00.Color       = [0.5,0.5,0.5];% pOpts.LineColor(3,:);
FemoralLegend.String{end+1}    = '';
FemoralLegend.String{end}    = 'Compensation -0.8 deg with Slope 0.0 deg';

pFemoralDemandLine_M06_06             = pOpts.gLine(axesFemoral, thetaFDVector_M06_06, torqueThetaFVector_M06_06);
pFemoralDemandLine_M06_06.Color       = [0.5,0.5,0.5];% pOpts.LineColor(4,:);
FemoralLegend.String{end+1}    = '';
FemoralLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.6 deg';

pFemoralDemandLine_M06_07             = pOpts.gLine(axesFemoral, thetaFDVector_M06_07, torqueThetaFVector_M06_07);
pFemoralDemandLine_M06_07.Color       = [0.5,0.5,0.5];% pOpts.LineColor(5,:);
FemoralLegend.String{end+1}    = '';
FemoralLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.7 deg';

pFemoralDemandLine_M06_08             = pOpts.gLine(axesFemoral, thetaFDVector_M06_08, torqueThetaFVector_M06_08);
pFemoralDemandLine_M06_08.Color       = pOpts.LineColor(1,:);
FemoralLegend.String{end+1}    = '';
FemoralLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.8 deg';

axesFemoral.XLimMode = 'manual';
axesFemoral.YLimMode = 'manual';

powerIsoFactor = linspace(0.1,10,100);
pFemoralPowerMax               = pOpts.gLine(axesFemoral, sqrt(maxThetaFPower).*powerIsoFactor, sqrt(maxThetaFPower)./powerIsoFactor);
pFemoralPowerMax.Color         = [0.3,0.3,0.3];
pFemoralPowerMax.LineStyle 	= '--';
FemoralLegend.String{end+1}    = '';
FemoralLegend.String{end}    = sprintf(['Maximum Femoral iso power demand line \n Max power = ',num2str(maxThetaFPower),' [W]']);


%%% Knee joint torque-speed demand figure 
figureKnee              = pOpts.gFigure('Knee Joint Torque Speed Plot');
figureKnee.Visible      = 'on';

axesKnee                = pOpts.gAxes(figureKnee);
axesKnee.XGrid          = 'on';
axesKnee.YGrid          = 'on';

axesKnee.XMinorGrid     = 'on';
axesKnee.YMinorGrid     = 'off';
axesKnee.XScale         = 'linear';
axesKnee.YScale         = 'linear';

axesKnee.Title.String   = sprintf('Knee Joint Torque - Speed Demand');
axesKnee.XLabel.String  = 'Speed [rad/sec]';
axesKnee.YLabel.String  = 'Torque [Nm]';

KneeLegend = legend(axesKnee);
KneeLegend.Location = 'southoutside';

pThetaKDemandLine_M06_00             = pOpts.gLine(axesKnee, thetaKDVector_M06_00, torqueThetaKVector_M06_00);
pThetaKDemandLine_M06_00.Color       = [0.5,0.5,0.5];%pOpts.LineColor(1,:);
KneeLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.0 deg';

pThetaKDemandLine_M07_00             = pOpts.gLine(axesKnee, thetaKDVector_M07_00, torqueThetaKVector_M07_00);
pThetaKDemandLine_M07_00.Color       = [0.5,0.5,0.5];% pOpts.LineColor(2,:);
KneeLegend.String{end+1}    = '';
KneeLegend.String{end}    = 'Compensation -0.7 deg with Slope 0.0 deg';

pThetaKDemandLine_M08_00             = pOpts.gLine(axesKnee, thetaKDVector_M08_00, torqueThetaKVector_M08_00);
pThetaKDemandLine_M08_00.Color       = [0.5,0.5,0.5];% pOpts.LineColor(3,:);
KneeLegend.String{end+1}    = '';
KneeLegend.String{end}    = 'Compensation -0.8 deg with Slope 0.0 deg';

pThetaKDemandLine_M06_06             = pOpts.gLine(axesKnee, thetaKDVector_M06_06, torqueThetaKVector_M06_06);
pThetaKDemandLine_M06_06.Color       = [0.5,0.5,0.5];% pOpts.LineColor(4,:);
KneeLegend.String{end+1}    = '';
KneeLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.6 deg';

pThetaKDemandLine_M06_07             = pOpts.gLine(axesKnee, thetaKDVector_M06_07, torqueThetaKVector_M06_07);
pThetaKDemandLine_M06_07.Color       = [0.5,0.5,0.5];% pOpts.LineColor(5,:);
KneeLegend.String{end+1}    = '';
KneeLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.7 deg';

pThetaKDemandLine_M06_08             = pOpts.gLine(axesKnee, thetaKDVector_M06_08, torqueThetaKVector_M06_08);
pThetaKDemandLine_M06_08.Color       = pOpts.LineColor(1,:);
KneeLegend.String{end+1}    = '';
KneeLegend.String{end}    = 'Compensation -0.6 deg with Slope 0.8 deg';

axesKnee.XLimMode = 'manual';
axesKnee.YLimMode = 'manual';

powerIsoFactor = linspace(0.1,10,100);
pThetaKPowerMax               = pOpts.gLine(axesKnee, sqrt(maxThetaKPower).*powerIsoFactor, sqrt(maxThetaKPower)./powerIsoFactor);
pThetaKPowerMax.Color         = [0.3,0.3,0.3];
pThetaKPowerMax.LineStyle 	= '--';
KneeLegend.String{end+1}    = '';
KneeLegend.String{end}    = sprintf(['Maximum knee iso power demand line \n Max power = ',num2str(maxThetaKPower),' [W]']);

%%% Femoral joint torque-time demand figure 
figureFemoralTime              = pOpts.gFigure('Femoral Joint Torque Timeseries Plot');
figureFemoralTime.Visible      = 'on';

axesFemoralTime                = pOpts.gAxes(figureFemoralTime);
axesFemoralTime.XGrid          = 'on';
axesFemoralTime.YGrid          = 'on';

axesFemoralTime.XMinorGrid     = 'on';
axesFemoralTime.YMinorGrid     = 'off';
axesFemoralTime.XScale         = 'linear';
axesFemoralTime.YScale         = 'linear';

axesFemoralTime.Title.String   = sprintf('Femoral joint torque timeseries');
axesFemoralTime.XLabel.String  = 'Time [sec]';
axesFemoralTime.YLabel.String  = 'Joint Torque [Nm]';

FemoralTimeLegend = legend(axesFemoralTime);
FemoralTimeLegend.Location = 'best';

pFemoralTimeDemandLine_M06_08             = pOpts.gLine(axesFemoralTime, timeVector_M06_08-timeVector_M06_08(1), torqueThetaFVector_M06_08);
pFemoralTimeDemandLine_M06_08.Color       = [0.3,0.3,0.3];%pOpts.LineColor(1,:);
FemoralTimeLegend.String{end}           	= 'Compensation -0.6 deg with Slope 0.8 deg';

%%% Knee joint torque-time demand figure 
figureKneeTime              = pOpts.gFigure('Knee Joint Torque Timeseries Plot');
figureKneeTime.Visible      = 'on';

axesKneeTime                = pOpts.gAxes(figureKneeTime);
axesKneeTime.XGrid          = 'on';
axesKneeTime.YGrid          = 'on';

axesKneeTime.XMinorGrid     = 'on';
axesKneeTime.YMinorGrid     = 'off';
axesKneeTime.XScale         = 'linear';
axesKneeTime.YScale         = 'linear';

axesKneeTime.Title.String   = sprintf('Knee joint torque timeseries');
axesKneeTime.XLabel.String  = 'Time [sec]';
axesKneeTime.YLabel.String  = 'Joint Torque [Nm]';

KneeTimeLegend = legend(axesKneeTime);
KneeTimeLegend.Location = 'best';

pKneeTimeDemandLine_M06_08             = pOpts.gLine(axesKneeTime, timeVector_M06_08-timeVector_M06_08(1), torqueThetaKVector_M06_08);
pKneeTimeDemandLine_M06_08.Color       = [0.3,0.3,0.3];%pOpts.LineColor(1,:);
KneeTimeLegend.String{end}           	= 'Compensation -0.6 deg with Slope 0.8 deg';

%%% Mechanical Power Plot 
figurePower                     = pOpts.gFigure('Femoral Joint Torque Timeseries Plot');
figurePower.Visible             = 'on';
figurePower.Position            = pOpts.figurePosition3;
tiledLayoutPower                = pOpts.gTiledLayout(figurePower, [3,1]);      
tiledLayoutPower.Title.String 	= motorName;

tileAxesPowerMechanical               = pOpts.gTileAxes(tiledLayoutPower, 1, [1,1]);
tileAxesPowerMechanical.XGrid          = 'on';
tileAxesPowerMechanical.YGrid          = 'on';

tileAxesPowerMechanical.XMinorGrid     = 'on';
tileAxesPowerMechanical.YMinorGrid     = 'off';
tileAxesPowerMechanical.XScale         = 'linear';
tileAxesPowerMechanical.YScale         = 'linear';

tileAxesPowerMechanical.Title.String   = sprintf('Mechanical power timeseries \nSlope: 0.8 [deg], Compensation: -0.6 [deg]');
tileAxesPowerMechanical.XLabel.String  = 'Time [sec]';
tileAxesPowerMechanical.YLabel.String  = 'Power [W]';

PowerMechanicalLegend                   = legend(tileAxesPowerMechanical);
PowerMechanicalLegend.Location          = 'northeastoutside';

pFemoralPowerMechanical                 = pOpts.gLine(tileAxesPowerMechanical, timeVector_M06_08, powerDemand_M06_08);
pFemoralPowerMechanical.Color           = pOpts.LineColor(1,:);
PowerMechanicalLegend.String{end}       = 'Total mechanical power';

pFemoralPowerMechanicalThetaF           = pOpts.gLine(tileAxesPowerMechanical, timeVector_M06_08, powerThetaFDemand_M06_08);
pFemoralPowerMechanicalThetaF.Color    = [1,0.5,0.5];
PowerMechanicalLegend.String{end+1}     = '';
PowerMechanicalLegend.String{end}       = 'Outer femoral joint mechanical power';

pFemoralPowerMechanicalPsiF           = pOpts.gLine(tileAxesPowerMechanical, timeVector_M06_08, powerPsiFDemand_M06_08);
pFemoralPowerMechanicalPsiF.Color    = [0.5,0.5,0.5];
PowerMechanicalLegend.String{end+1}     = '';
PowerMechanicalLegend.String{end}       = 'Inner femoral joint mechanical power';

pFemoralPowerMechanicalThetaK           = pOpts.gLine(tileAxesPowerMechanical, timeVector_M06_08, powerThetaKDemand_M06_08);
pFemoralPowerMechanicalThetaK.Color    = [1,0.5,0.5];
pFemoralPowerMechanicalThetaK.LineStyle = '--';
PowerMechanicalLegend.String{end+1}     = '';
PowerMechanicalLegend.String{end}       = 'Outer knee joint mechanical power';

pFemoralPowerMechanicalPsiK           = pOpts.gLine(tileAxesPowerMechanical, timeVector_M06_08, powerPsiKDemand_M06_08);
pFemoralPowerMechanicalPsiK.Color    = [0.5,0.5,0.5];
pFemoralPowerMechanicalPsiK.LineStyle = '--';
PowerMechanicalLegend.String{end+1}     = '';
PowerMechanicalLegend.String{end}       = 'Inner knee joint mechanical power';

% Nexttile electrical power tile
tileAxesPowerElectrical               = pOpts.gTileAxes(tiledLayoutPower, 2, [1,1]);
tileAxesPowerElectrical.XGrid          = 'on';
tileAxesPowerElectrical.YGrid          = 'on';

tileAxesPowerElectrical.XMinorGrid     = 'on';
tileAxesPowerElectrical.YMinorGrid     = 'off';
tileAxesPowerElectrical.XScale         = 'linear';
tileAxesPowerElectrical.YScale         = 'linear';

tileAxesPowerElectrical.Title.String   = sprintf('Electrical power timeseries \nSlope: 0.8 [deg], Compensation: -0.6 [deg]');
tileAxesPowerElectrical.XLabel.String  = 'Time [sec]';
tileAxesPowerElectrical.YLabel.String  = 'Power [W]';

PowerElectricalLegend                   = legend(tileAxesPowerElectrical);
PowerElectricalLegend.Location          = 'northeastoutside';

pFemoralPowerElectrical                 = pOpts.gLine(tileAxesPowerElectrical, timeVector_M06_08, powerElDemand_M06_08);
pFemoralPowerElectrical.Color           = [249,166,2]/255;
PowerElectricalLegend.String{end}       = 'Total electrical power';

pFemoralPowerElectricalThetaF           = pOpts.gLine(tileAxesPowerElectrical, timeVector_M06_08, powerThetaFElDemand_M06_08);
pFemoralPowerElectricalThetaF.Color    = [0.7,0.7,0.5];
PowerElectricalLegend.String{end+1}     = '';
PowerElectricalLegend.String{end}       = 'Outer femoral joint electrical power';

pFemoralPowerElectricalPsiF           = pOpts.gLine(tileAxesPowerElectrical, timeVector_M06_08, powerPsiFElDemand_M06_08);
pFemoralPowerElectricalPsiF.Color    = [0.5,0.5,0.5];
PowerElectricalLegend.String{end+1}     = '';
PowerElectricalLegend.String{end}       = 'Inner femoral joint electrical power';

pFemoralPowerElectricalThetaK           = pOpts.gLine(tileAxesPowerElectrical, timeVector_M06_08, powerThetaKElDemand_M06_08);
pFemoralPowerElectricalThetaK.Color    = [0.7,0.7,0.5];
pFemoralPowerElectricalThetaK.LineStyle = '--';
PowerElectricalLegend.String{end+1}     = '';
PowerElectricalLegend.String{end}       = 'Outer knee joint electrical power';

pFemoralPowerElectricalPsiK           = pOpts.gLine(tileAxesPowerElectrical, timeVector_M06_08, powerPsiKElDemand_M06_08);
pFemoralPowerElectricalPsiK.Color    = [0.5,0.5,0.5];
pFemoralPowerElectricalPsiK.LineStyle = '--';
PowerElectricalLegend.String{end+1}     = '';
PowerElectricalLegend.String{end}       = 'Inner knee joint electrical power';

% Nexttile electrical power tile (No Knees Actuation)
tileAxesPowerElectrical               = pOpts.gTileAxes(tiledLayoutPower, 3, [1,1]);
tileAxesPowerElectrical.XGrid          = 'on';
tileAxesPowerElectrical.YGrid          = 'on';

tileAxesPowerElectrical.XMinorGrid     = 'on';
tileAxesPowerElectrical.YMinorGrid     = 'off';
tileAxesPowerElectrical.XScale         = 'linear';
tileAxesPowerElectrical.YScale         = 'linear';

tileAxesPowerElectrical.Title.String   = sprintf('Electrical power timeseries \nNo knees actuation \nSlope: 0.8 [deg], Compensation: -0.6 [deg]');
tileAxesPowerElectrical.XLabel.String  = 'Time [sec]';
tileAxesPowerElectrical.YLabel.String  = 'Power [W]';

PowerElectricalLegend                   = legend(tileAxesPowerElectrical);
PowerElectricalLegend.Location          = 'northeastoutside';

pFemoralPowerElectrical                 = pOpts.gLine(tileAxesPowerElectrical, timeVector_M06_08, powerElDemand_M06_08-powerThetaKElDemand_M06_08-powerPsiKElDemand_M06_08);
pFemoralPowerElectrical.Color           = [249,166,2]/255;
PowerElectricalLegend.String{end}       = 'Total electrical power';

pFemoralPowerElectricalThetaF           = pOpts.gLine(tileAxesPowerElectrical, timeVector_M06_08, powerThetaFElDemand_M06_08);
pFemoralPowerElectricalThetaF.Color    = [0.7,0.7,0.5];
PowerElectricalLegend.String{end+1}     = '';
PowerElectricalLegend.String{end}       = 'Outer femoral joint electrical power';

pFemoralPowerElectricalPsiF           = pOpts.gLine(tileAxesPowerElectrical, timeVector_M06_08, powerPsiFElDemand_M06_08);
pFemoralPowerElectricalPsiF.Color    = [0.5,0.5,0.5];
PowerElectricalLegend.String{end+1}     = '';
PowerElectricalLegend.String{end}       = 'Inner femoral joint electrical power';


%%% Femoral joint current demand figure 
figureFemoralCurrent                = pOpts.gFigure('Femoral Joint Current Demands Plot');
figureFemoralCurrent.Visible        = 'on';

axesFemoralCurrent                  = pOpts.gAxes(figureFemoralCurrent);
axesFemoralCurrent.XGrid            = 'on';
axesFemoralCurrent.YGrid            = 'on';

axesFemoralCurrent.XMinorGrid       = 'on';
axesFemoralCurrent.YMinorGrid       = 'off';
axesFemoralCurrent.XScale           = 'linear';
axesFemoralCurrent.YScale           = 'linear';

axesFemoralCurrent.Title.String     = sprintf(['Femoral Joint Current Demands \n',motorName]);
axesFemoralCurrent.XLabel.String    = 'Time [sec]';
axesFemoralCurrent.YLabel.String    = 'Current [A]';

FemoralCurrentLegend = legend(axesFemoralCurrent);
FemoralCurrentLegend.Location = 'best';

pFemoralThetaCurrentDemandLine_M06_08       	= pOpts.gLine(axesFemoralCurrent, [timeVector_M06_08(1),timeVector_M06_08(end)]-timeVector_M06_08(1),[currentRmsThetaFDemand_M06_08(end),currentRmsThetaFDemand_M06_08(end)]);
pFemoralThetaCurrentDemandLine_M06_08.Color 	= [249,166,2]/255;%pOpts.LineColor(1,:);
FemoralCurrentLegend.String{end}                = 'Rms current demand for θ_{F}';

pFemoralThetaCurrentDemandLine_M06_08           = pOpts.gLine(axesFemoralCurrent, timeVector_M06_08-timeVector_M06_08(1), currentMotorThetaFDemand_M06_08);
pFemoralThetaCurrentDemandLine_M06_08.Color     = [0.7,0.7,0.5];% pOpts.LineColor(3,:);
FemoralCurrentLegend.String{end+1}              = '';
FemoralCurrentLegend.String{end}                = 'Motor current demand for θ_{F}';

pFemoralThetaCurrentDemandLine_M06_08           = pOpts.gLine(axesFemoralCurrent, [timeVector_M06_08(1),timeVector_M06_08(end)]-timeVector_M06_08(1), [currentRated,currentRated]);
pFemoralThetaCurrentDemandLine_M06_08.Color     = [0.5,0.5,0.5];% pOpts.LineColor(3,:);
FemoralCurrentLegend.String{end+1}              = '';
FemoralCurrentLegend.String{end}                = 'Motor current limitation';

%%% Knee joint current demand figure 
figureKneeCurrent                = pOpts.gFigure('Knee Joint Current Demands Plot');
figureKneeCurrent.Visible        = 'on';

axesKneeCurrent                  = pOpts.gAxes(figureKneeCurrent);
axesKneeCurrent.XGrid            = 'on';
axesKneeCurrent.YGrid            = 'on';

axesKneeCurrent.XMinorGrid       = 'on';
axesKneeCurrent.YMinorGrid       = 'off';
axesKneeCurrent.XScale           = 'linear';
axesKneeCurrent.YScale           = 'linear';

axesKneeCurrent.Title.String     = sprintf(['Knee Joint Current Demands \n',motorName]);
axesKneeCurrent.XLabel.String    = 'Time [sec]';
axesKneeCurrent.YLabel.String    = 'Current [A]';

KneeCurrentLegend = legend(axesKneeCurrent);
KneeCurrentLegend.Location = 'best';

pKneeThetaCurrentDemandLine_M06_08       	= pOpts.gLine(axesKneeCurrent, [timeVector_M06_08(1),timeVector_M06_08(end)]-timeVector_M06_08(1),[currentRmsThetaKDemand_M06_08(end),currentRmsThetaKDemand_M06_08(end)]);
pKneeThetaCurrentDemandLine_M06_08.Color 	= [249,166,2]/255;%pOpts.LineColor(1,:);
KneeCurrentLegend.String{end}                = 'Rms current demand for θ_{K}';

pKneeThetaCurrentDemandLine_M06_08           = pOpts.gLine(axesKneeCurrent, timeVector_M06_08-timeVector_M06_08(1), currentMotorThetaKDemand_M06_08);
pKneeThetaCurrentDemandLine_M06_08.Color     = [0.7,0.7,0.5];% pOpts.LineColor(3,:);
KneeCurrentLegend.String{end+1}              = '';
KneeCurrentLegend.String{end}                = 'Motor current demand for θ_{K}';

pKneeThetaCurrentDemandLine_M06_08           = pOpts.gLine(axesKneeCurrent, [timeVector_M06_08(1),timeVector_M06_08(end)]-timeVector_M06_08(1), [currentRated,currentRated]);
pKneeThetaCurrentDemandLine_M06_08.Color     = [0.5,0.5,0.5];% pOpts.LineColor(3,:);
KneeCurrentLegend.String{end+1}              = '';
KneeCurrentLegend.String{end}                = 'Motor current limitation';

