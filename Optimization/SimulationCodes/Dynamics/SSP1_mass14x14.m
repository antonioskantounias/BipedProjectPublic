function [Mass_14x14] = SSP1_mass14x14(t,x,parameters,footshape)

M_6x6=mass6x6(x,parameters);

Lamda1_6x2=Lamda1_J(x,parameters,footshape);
Lamda1_2x6=Lamda1_6x2';

M_top=[eye(6),zeros(6,8)];
M_mid=[zeros(6),M_6x6,-Lamda1_6x2];
M_bot=[Lamda1_2x6,zeros(2,8)];

Mass_14x14=[M_top;M_mid;M_bot];

end

