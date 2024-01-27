function [Mass_14x14] = SSP2_mass14x14(t,x,parameters,footshape)

M_6x6=mass6x6(x,parameters);

Lamda2_6x2=Lamda2_J(x,parameters,footshape);
Lamda2_2x6=Lamda2_6x2';

M_top=[eye(6),zeros(6,8)];
M_mid=[zeros(6),M_6x6,-Lamda2_6x2];
M_bot=[Lamda2_2x6,zeros(2,8)];

Mass_14x14=[M_top;M_mid;M_bot];

end

