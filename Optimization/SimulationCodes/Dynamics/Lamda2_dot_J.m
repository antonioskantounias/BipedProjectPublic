function [Ld2] = Lamda2_dot_J(x,param,footshape)

Ld=Lamda_dot_J(x,param,footshape);
Ld2=Ld(1:6,3:4);

end