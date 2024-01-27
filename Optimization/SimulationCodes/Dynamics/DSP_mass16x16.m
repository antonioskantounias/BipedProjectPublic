function [Mass_16x16] = DSP_mass16x16(t,x,param,footshape)


Mass_14x14 = SSP1_mass14x14(t,x,param,footshape);

Lamda2_6x2=Lamda2_J(x,param,footshape);
Lamda2_2x6=Lamda2_6x2';

extra_14x2=[zeros(6,2);-Lamda2_6x2;zeros(2,2)];
Mass_14x16=[Mass_14x14,extra_14x2];

extra_2x16=[Lamda2_2x6,zeros(2,10)];
Mass_16x16=[Mass_14x16;extra_2x16];

end

