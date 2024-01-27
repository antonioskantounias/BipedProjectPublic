function [L2] = Lamda2_J(x,param,footshape)

L=Lamda_J(x,param,footshape);
L2=L(1:6,3:4);

end
