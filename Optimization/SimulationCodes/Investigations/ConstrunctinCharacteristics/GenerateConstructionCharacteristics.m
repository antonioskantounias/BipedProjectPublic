%% Workspace generation
clear all
close all
GenerateWorkSpace

%% Generate construction characteristics

% Insert construction characteristics
crossSectionDataFemoral.crossSectionName 	= 'Cylindrical_Automatic';

crossSectionDataTibial.crossSectionName 	= 'Cylindrical_Automatic';

materialNameFemoral                 = 'Aluminum';
materialNameTibial                  = 'Aluminum';

ConstructionParameters.Lall     	= 0.550;     % [m]
ConstructionParameters.LFFactor  	= 0.5455;
ConstructionParameters.mHFactor    	= 0.9;
ConstructionParameters.sFFemoral  	= 250;
ConstructionParameters.sFTibial    	= 150;

% Generate constraints related to construction characteristics
[Constraints, RobotLegs] = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParameters);

%% Calcualate constraints for LFFactor

% Undimensional values
fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(4, 1)

%---------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan   	= [0.2, 0.8];
LFFactorVector 	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
mFFactorVector	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew       = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mFFactorVector(iLength)         = Constraints.Center.mFFactor;
end

plot(LFFactorVector, mFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs mFFactor')
xlabel('Robot LFFactor')
ylabel('Robot mFFactor')
grid on;

%----------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan  	= [0.2, 0.8];
LFFactorVector	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
mTFactorVector 	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mTFactorVector(iLength)        = Constraints.Center.mTFactor;
end

plot(LFFactorVector, mTFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs mTFactor')
xlabel('Robot LFFactor')
ylabel('Robot mTFactor')
grid on;

%----------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan  	= [0.2, 0.8];
LFFactorVector	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
IFFactorVector 	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFFactorVector(iLength)        = Constraints.Center.IFFactor;
end

plot(LFFactorVector, IFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs IFFactor')
xlabel('Robot LFFactor')
ylabel('Robot IFFactor')
grid on;

%----------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan  	= [0.2, 0.8];
LFFactorVector	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
ITFactorVector 	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITFactorVector(iLength)        = Constraints.Center.ITFactor;
end

plot(LFFactorVector, ITFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs ITFactor')
xlabel('Robot LFFactor')
ylabel('Robot ITFactor')
grid on;

% Dimensional values

fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(5, 1)

%---------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan   	= [0.2, 0.8];
LFFactorVector 	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
MallVector	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    MallVector(iLength)        = Constraints.Data.Mall;
end

plot(LFFactorVector, MallVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs Mall')
xlabel('Robot LFFactor')
ylabel('Robot Mall')
grid on;

%---------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan   	= [0.2, 0.8];
LFFactorVector 	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
IFVector	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFVector(iLength)        = Constraints.Data.IF;
end

plot(LFFactorVector, IFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs IF')
xlabel('Robot LFFactor')
ylabel('Robot IF')
grid on;

%---------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan   	= [0.2, 0.8];
LFFactorVector 	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
ITVector	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITVector(iLength)        = Constraints.Data.IT;
end

plot(LFFactorVector, ITVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs IT')
xlabel('Robot LFFactor')
ylabel('Robot IT')
grid on;

%---------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan   	= [0.2, 0.8];
LFFactorVector 	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
AreaFVector	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaFVector(iLength)        = Constraints.Data.AreaF;
end

plot(LFFactorVector, AreaFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs AreaF')
xlabel('Robot LFFactor')
ylabel('Robot AreaF')
grid on;

%---------------------
nexttile
numOfLFFactors	= 100;
LFFactorSpan   	= [0.2, 0.8];
LFFactorVector 	= linspace(LFFactorSpan(1), LFFactorSpan(2), numOfLFFactors);
AreaTVector	= zeros(1, numOfLFFactors);

for iLength = 1 : numOfLFFactors
    LFFactor                        = LFFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.LFFactor = LFFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaTVector(iLength)        = Constraints.Data.AreaT;
end

plot(LFFactorVector, AreaTVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot LFFactor vs AreaT')
xlabel('Robot LFFactor')
ylabel('Robot AreaT')
grid on;

%% Calcualate constraints for mHFactor

% Undimensional values
fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(4, 1)

%---------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan   	= [0.2, 0.8];
mHFactorVector 	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
mFFactorVector	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mFFactorVector(iLength)        = Constraints.Center.mFFactor;
end

plot(mHFactorVector, mFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs mFFactor')
xlabel('Robot mHFactor')
ylabel('Robot mFFactor')
grid on;

%----------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan  	= [0.2, 0.8];
mHFactorVector	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
mTFactorVector 	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mTFactorVector(iLength)        = Constraints.Center.mTFactor;
end

plot(mHFactorVector, mTFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs mTFactor')
xlabel('Robot mHFactor')
ylabel('Robot mTFactor')
grid on;

%----------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan  	= [0.2, 0.8];
mHFactorVector	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
IFFactorVector 	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFFactorVector(iLength)        = Constraints.Center.IFFactor;
end

plot(mHFactorVector, IFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs IFFactor')
xlabel('Robot mHFactor')
ylabel('Robot IFFactor')
grid on;

%----------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan  	= [0.2, 0.8];
mHFactorVector	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
ITFactorVector 	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITFactorVector(iLength)        = Constraints.Center.ITFactor;
end

plot(mHFactorVector, ITFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs ITFactor')
xlabel('Robot mHFactor')
ylabel('Robot ITFactor')
grid on;

% Dimensional values

fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(5, 1)

%---------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan   	= [0.2, 0.8];
mHFactorVector 	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
MallVector	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    MallVector(iLength)        = Constraints.Data.Mall;
end

plot(mHFactorVector, MallVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs Mall')
xlabel('Robot mHFactor')
ylabel('Robot Mall')
grid on;

%---------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan   	= [0.2, 0.8];
mHFactorVector 	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
IFVector	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFVector(iLength)        = Constraints.Data.IF;
end

plot(mHFactorVector, IFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs IF')
xlabel('Robot mHFactor')
ylabel('Robot IF')
grid on;

%---------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan   	= [0.2, 0.8];
mHFactorVector 	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
ITVector	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITVector(iLength)        = Constraints.Data.IT;
end

plot(mHFactorVector, ITVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs IT')
xlabel('Robot mHFactor')
ylabel('Robot IT')
grid on;

%---------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan   	= [0.2, 0.8];
mHFactorVector 	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
AreaFVector	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaFVector(iLength)        = Constraints.Data.AreaF;
end

plot(mHFactorVector, AreaFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs AreaF')
xlabel('Robot mHFactor')
ylabel('Robot AreaF')
grid on;

%---------------------
nexttile
numOfmHFactors	= 100;
mHFactorSpan   	= [0.2, 0.8];
mHFactorVector 	= linspace(mHFactorSpan(1), mHFactorSpan(2), numOfmHFactors);
AreaTVector	= zeros(1, numOfmHFactors);

for iLength = 1 : numOfmHFactors
    mHFactor                        = mHFactorVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.mHFactor = mHFactor;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaTVector(iLength)        = Constraints.Data.AreaT;
end

plot(mHFactorVector, AreaTVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot mHFactor vs AreaT')
xlabel('Robot mHFactor')
ylabel('Robot AreaT')
grid on;

%% Calcualate constraints for Lall

% Undimensional values
fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(4, 1)

%---------------------
nexttile
numOfLalls	= 100;
LallSpan   	= [0.2, 0.8];
LallVector 	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
mFFactorVector	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mFFactorVector(iLength)        = Constraints.Center.mFFactor;
end

plot(LallVector, mFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs mFFactor')
xlabel('Robot Lall')
ylabel('Robot mFFactor')
grid on;

%----------------------
nexttile
numOfLalls	= 100;
LallSpan  	= [0.2, 0.8];
LallVector	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
mTFactorVector 	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mTFactorVector(iLength)        = Constraints.Center.mTFactor;
end

plot(LallVector, mTFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs mTFactor')
xlabel('Robot Lall')
ylabel('Robot mTFactor')
grid on;

%----------------------
nexttile
numOfLalls	= 100;
LallSpan  	= [0.2, 0.8];
LallVector	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
IFFactorVector 	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFFactorVector(iLength)        = Constraints.Center.IFFactor;
end

plot(LallVector, IFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs IFFactor')
xlabel('Robot Lall')
ylabel('Robot IFFactor')
grid on;

%----------------------
nexttile
numOfLalls	= 100;
LallSpan  	= [0.2, 0.8];
LallVector	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
ITFactorVector 	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITFactorVector(iLength)        = Constraints.Center.ITFactor;
end

plot(LallVector, ITFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs ITFactor')
xlabel('Robot Lall')
ylabel('Robot ITFactor')
grid on;

% Dimensional values

fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(5, 1)

%---------------------
nexttile
numOfLalls	= 100;
LallSpan   	= [0.2, 0.8];
LallVector 	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
MallVector	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    MallVector(iLength)        = Constraints.Data.Mall;
end

plot(LallVector, MallVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs Mall')
xlabel('Robot Lall')
ylabel('Robot Mall')
grid on;

%---------------------
nexttile
numOfLalls	= 100;
LallSpan   	= [0.2, 0.8];
LallVector 	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
IFVector	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFVector(iLength)        = Constraints.Data.IF;
end

plot(LallVector, IFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs IF')
xlabel('Robot Lall')
ylabel('Robot IF')
grid on;

%---------------------
nexttile
numOfLalls	= 100;
LallSpan   	= [0.2, 0.8];
LallVector 	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
ITVector	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITVector(iLength)        = Constraints.Data.IT;
end

plot(LallVector, ITVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs IT')
xlabel('Robot Lall')
ylabel('Robot IT')
grid on;

%---------------------
nexttile
numOfLalls	= 100;
LallSpan   	= [0.2, 0.8];
LallVector 	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
AreaFVector	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaFVector(iLength)        = Constraints.Data.AreaF;
end

plot(LallVector, AreaFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs AreaF')
xlabel('Robot Lall')
ylabel('Robot AreaF')
grid on;

%---------------------
nexttile
numOfLalls	= 100;
LallSpan   	= [0.2, 0.8];
LallVector 	= linspace(LallSpan(1), LallSpan(2), numOfLalls);
AreaTVector	= zeros(1, numOfLalls);

for iLength = 1 : numOfLalls
    Lall                        = LallVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.Lall = Lall;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaTVector(iLength)        = Constraints.Data.AreaT;
end

plot(LallVector, AreaTVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot Lall vs AreaT')
xlabel('Robot Lall')
ylabel('Robot AreaT')
grid on;

%% Calcualate constraints for sFFemoral

% Undimensional values
fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(4, 1)

%---------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan   	= [10, 30];
sFFemoralVector 	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
mFFactorVector	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mFFactorVector(iLength)        = Constraints.Center.mFFactor;
end

plot(sFFemoralVector, mFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs mFFactor')
xlabel('Robot sFFemoral')
ylabel('Robot mFFactor')
grid on;

%----------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan  	= [10, 30];
sFFemoralVector	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
mTFactorVector 	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mTFactorVector(iLength)        = Constraints.Center.mTFactor;
end

plot(sFFemoralVector, mTFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs mTFactor')
xlabel('Robot sFFemoral')
ylabel('Robot mTFactor')
grid on;

%----------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan  	= [10, 30];
sFFemoralVector	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
IFFactorVector 	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFFactorVector(iLength)        = Constraints.Center.IFFactor;
end

plot(sFFemoralVector, IFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs IFFactor')
xlabel('Robot sFFemoral')
ylabel('Robot IFFactor')
grid on;

%----------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan  	= [10, 30];
sFFemoralVector	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
ITFactorVector 	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITFactorVector(iLength)        = Constraints.Center.ITFactor;
end

plot(sFFemoralVector, ITFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs ITFactor')
xlabel('Robot sFFemoral')
ylabel('Robot ITFactor')
grid on;

% Dimensional values

fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(5, 1)

%---------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan   	= [10, 30];
sFFemoralVector 	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
MallVector	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    MallVector(iLength)        = Constraints.Data.Mall;
end

plot(sFFemoralVector, MallVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs Mall')
xlabel('Robot sFFemoral')
ylabel('Robot Mall')
grid on;

%---------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan   	= [10, 30];
sFFemoralVector 	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
IFVector	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFVector(iLength)        = Constraints.Data.IF;
end

plot(sFFemoralVector, IFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs IF')
xlabel('Robot sFFemoral')
ylabel('Robot IF')
grid on;

%---------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan   	= [10, 30];
sFFemoralVector 	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
ITVector	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITVector(iLength)        = Constraints.Data.IT;
end

plot(sFFemoralVector, ITVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs IT')
xlabel('Robot sFFemoral')
ylabel('Robot IT')
grid on;

%---------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan   	= [10, 30];
sFFemoralVector 	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
AreaFVector	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaFVector(iLength)        = Constraints.Data.AreaF;
end

plot(sFFemoralVector, AreaFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs AreaF')
xlabel('Robot sFFemoral')
ylabel('Robot AreaF')
grid on;

%---------------------
nexttile
numOfsFFemorals	= 100;
sFFemoralSpan   	= [10, 30];
sFFemoralVector 	= linspace(sFFemoralSpan(1), sFFemoralSpan(2), numOfsFFemorals);
AreaTVector	= zeros(1, numOfsFFemorals);

for iLength = 1 : numOfsFFemorals
    sFFemoral                        = sFFemoralVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFFemoral = sFFemoral;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaTVector(iLength)        = Constraints.Data.AreaT;
end

plot(sFFemoralVector, AreaTVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFFemoral vs AreaT')
xlabel('Robot sFFemoral')
ylabel('Robot AreaT')
grid on;

%% Calcualate constraints for sFTibial

% Undimensional values
fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(4, 1)

%---------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan   	= [10, 30];
sFTibialVector 	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
mFFactorVector	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mFFactorVector(iLength)        = Constraints.Center.mFFactor;
end

plot(sFTibialVector, mFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs mFFactor')
xlabel('Robot sFTibial')
ylabel('Robot mFFactor')
grid on;

%----------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan  	= [10, 30];
sFTibialVector	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
mTFactorVector 	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    mTFactorVector(iLength)        = Constraints.Center.mTFactor;
end

plot(sFTibialVector, mTFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs mTFactor')
xlabel('Robot sFTibial')
ylabel('Robot mTFactor')
grid on;

%----------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan  	= [10, 30];
sFTibialVector	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
IFFactorVector 	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFFactorVector(iLength)        = Constraints.Center.IFFactor;
end

plot(sFTibialVector, IFFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs IFFactor')
xlabel('Robot sFTibial')
ylabel('Robot IFFactor')
grid on;

%----------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan  	= [10, 30];
sFTibialVector	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
ITFactorVector 	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITFactorVector(iLength)        = Constraints.Center.ITFactor;
end

plot(sFTibialVector, ITFactorVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs ITFactor')
xlabel('Robot sFTibial')
ylabel('Robot ITFactor')
grid on;

% Dimensional values

fig = figure;
fig.Position = [40, 40, 1300, 700];
tiledlayout(5, 1)

%---------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan   	= [10, 30];
sFTibialVector 	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
MallVector	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    MallVector(iLength)        = Constraints.Data.Mall;
end

plot(sFTibialVector, MallVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs Mall')
xlabel('Robot sFTibial')
ylabel('Robot Mall')
grid on;

%---------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan   	= [10, 30];
sFTibialVector 	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
IFVector	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    IFVector(iLength)        = Constraints.Data.IF;
end

plot(sFTibialVector, IFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs IF')
xlabel('Robot sFTibial')
ylabel('Robot IF')
grid on;

%---------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan   	= [10, 30];
sFTibialVector 	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
ITVector	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    ITVector(iLength)        = Constraints.Data.IT;
end

plot(sFTibialVector, ITVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs IT')
xlabel('Robot sFTibial')
ylabel('Robot IT')
grid on;

%---------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan   	= [10, 30];
sFTibialVector 	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
AreaFVector	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaFVector(iLength)        = Constraints.Data.AreaF;
end

plot(sFTibialVector, AreaFVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs AreaF')
xlabel('Robot sFTibial')
ylabel('Robot AreaF')
grid on;

%---------------------
nexttile
numOfsFTibials	= 100;
sFTibialSpan   	= [10, 30];
sFTibialVector 	= linspace(sFTibialSpan(1), sFTibialSpan(2), numOfsFTibials);
AreaTVector	= zeros(1, numOfsFTibials);

for iLength = 1 : numOfsFTibials
    sFTibial                        = sFTibialVector(iLength);
    ConstructionParametersNew = ConstructionParameters; ConstructionParametersNew.sFTibial = sFTibial;
    Constraints                     = generateConstraintsBasedOnActualModel(materialNameFemoral, materialNameTibial, crossSectionDataFemoral, crossSectionDataTibial, ConstructionParametersNew);
    AreaTVector(iLength)        = Constraints.Data.AreaT;
end

plot(sFTibialVector, AreaTVector, 'color', [0.5,0.5,0], 'LineWidth', 2)
title('Robot sFTibial vs AreaT')
xlabel('Robot sFTibial')
ylabel('Robot AreaT')
grid on;

