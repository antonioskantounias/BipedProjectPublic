% Matlab model
HipMatlab = [0.0502599145820417,0.598672988894794];

FemoralOuterDownMatlab = [0.0351700303669779,0.439988851709075]-HipMatlab;
FemoralOuterCMMatlab = [0.0458836493594420,0.552652498542001]-HipMatlab; 
TibialOuterUpMatlab = [0.0242653628698635,0.399305708377454]-HipMatlab;
TibialOuterDownMatlab = [9.90057741653557e-05,0.00945400941395957]-HipMatlab;
TibialOuterCMMatlab = [0.0257596597744823,0.190293436353897]-HipMatlab; 
FootOuterEdgeMatlab = [0.0786831995221517,0.00456753303418829]-HipMatlab;

FemoralInnerDownMatlab = [0.0691928034230089,0.440401368823046]-HipMatlab;
FemoralInnerCMMatlab = [0.0555980901011385,0.554047908447133]-HipMatlab; 
TibialInnerUpMatlab = [0.0660684860265306,0.398726816883165]-HipMatlab;
TibialInnerDownMatlab = [0.110520377066093,0.0106644644409227]-HipMatlab;
TibialInnerCMMatlab = [0.104128139320144,0.193203519977781]-HipMatlab; 
FootInnerEdgeMatlab = [0.188746536631144,0.0196099168126218]-HipMatlab;

FemoralSizeOuterMatlab = norm(FemoralOuterDownMatlab);
FemoralSizeCMOuterMatlab = norm(HipMatlab-FemoralOuterCMMatlab);
TibialSizeOuterMatlab = norm(TibialOuterUpMatlab-TibialOuterDownMatlab);
TibialSizeCMOuterMatlab = norm(TibialOuterUpMatlab-TibialOuterCMMatlab);
FootSizeOuterMatlab = norm(TibialOuterDownMatlab-FootOuterEdgeMatlab);

FemoralSizeInnerMatlab = norm(FemoralInnerDownMatlab);
FemoralSizeCMInnerMatlab = norm(HipMatlab-FemoralInnerCMMatlab);
TibialSizeInnerMatlab = norm(TibialInnerUpMatlab-TibialInnerDownMatlab);
TibialSizeCMInnerMatlab = norm(TibialInnerUpMatlab-TibialInnerCMMatlab);
FootSizeInnerMatlab = norm(TibialInnerDownMatlab-FootInnerEdgeMatlab);

% Cad model
HipCad = [205.07189882,597.04591210]*1e-3;

FemoralOuterDownCad = [189.98201718,438.36177403]*1e-3-HipCad;
FemoralOuterCMCad = [200.73191056,551.02201478]*1e-3-HipCad; 
TibialOuterUpCad = [179.07734758,397.67863166]*1e-3-HipCad;
TibialOuterDownCad = [154.91099049,7.82693270]*1e-3-HipCad;
TibialOuterCMCad = [180.57151272,188.66608800]*1e-3-HipCad; 
FootOuterEdgeCad = [233.53541981,2.95311519]*1e-3-HipCad;

FemoralInnerDownCad = [224.00478839,438.77429198]*1e-3-HipCad;
FemoralInnerCMCad = [210.44393493,552.42487997]*1e-3-HipCad; 
TibialInnerUpCad = [220.88047074,397.09974004]*1e-3-HipCad;
TibialInnerDownCad = [265.33236178,9.03738760]*1e-3-HipCad;
TibialInnerCMCad = [258.94010212,191.57662544]*1e-3-HipCad; 
FootInnerEdgeCad = [343.59591965,18.00234677]*1e-3-HipCad;

FemoralSizeOuterCad = norm(FemoralOuterDownCad);
FemoralSizeCMOuterCad = norm(HipMatlab-FemoralOuterCMCad);
TibialSizeOuterCad = norm(TibialOuterUpCad-TibialOuterDownCad);
TibialSizeCMOuterCad = norm(TibialOuterUpCad-TibialOuterCMCad);
FootSizeOuterCad = norm(TibialOuterDownCad-FootOuterEdgeCad);

FemoralSizeInnerCad = norm(FemoralInnerDownCad);
FemoralSizeCMInnerCad = norm(HipMatlab-FemoralInnerCMCad);
TibialSizeInnerCad = norm(TibialInnerUpCad-TibialInnerDownCad);
TibialSizeCMInnerCad = norm(TibialInnerUpCad-TibialInnerCMCad);
FootSizeInnerCad = norm(TibialInnerDownCad-FootInnerEdgeCad);

% Models difference
% Cad model

FemoralOuterDownDiff = FemoralOuterDownCad-FemoralOuterDownMatlab;
FemoralOuterCMDiff = FemoralOuterCMCad-FemoralOuterCMMatlab; 
TibialOuterUpDiff = TibialOuterUpCad-TibialOuterUpMatlab;
TibialOuterDownDiff = TibialOuterDownCad-TibialOuterDownMatlab;
TibialOuterCMDiff = TibialOuterCMCad-TibialOuterCMMatlab; 
FootOuterEdgeDiff = FootOuterEdgeCad-FootOuterEdgeMatlab;

FemoralInnerDownDiff = FemoralInnerDownCad-FemoralInnerDownMatlab;
FemoralInnerCMDiff = FemoralInnerCMCad-FemoralInnerCMMatlab; 
TibialInnerUpDiff = TibialInnerUpCad-TibialInnerUpMatlab;
TibialInnerDownDiff = TibialInnerDownCad-TibialInnerDownMatlab;
TibialInnerCMDiff = TibialInnerCMCad-TibialInnerCMMatlab; 
FootInnerEdgeDiff = FootInnerEdgeCad-FootInnerEdgeMatlab;

FemoralSizeOuterDiff = FemoralSizeOuterCad-FemoralSizeOuterMatlab;
FemoralSizeCMOuterDiff = FemoralSizeCMOuterCad-FemoralSizeCMOuterMatlab;
TibialSizeOuterDiff = TibialSizeOuterCad-TibialSizeOuterMatlab;
TibialSizeCMOuterDiff = TibialSizeCMOuterCad-TibialSizeCMOuterMatlab;
FootSizeOuterDiff = FootSizeOuterCad-FootSizeOuterMatlab;

FemoralSizeInnerDiff = FemoralSizeInnerCad-FemoralSizeInnerMatlab;
FemoralSizeCMInnerDiff = FemoralSizeCMInnerCad-FemoralSizeCMInnerMatlab;
TibialSizeInnerDiff = TibialSizeInnerCad-TibialSizeInnerMatlab;
TibialSizeCMInnerDiff = TibialSizeCMInnerCad-TibialSizeCMInnerMatlab;
FootSizeInnerDiff = FootSizeInnerCad-FootSizeInnerMatlab;

