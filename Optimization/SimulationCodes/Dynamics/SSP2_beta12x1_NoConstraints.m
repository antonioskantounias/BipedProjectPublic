function [matrix_B] = SSP2_beta12x1_NoConstraints(t,x,parameters,footshape)

matrix_B(1,1) = x(7);
matrix_B(2,1) = x(8);
matrix_B(3,1) = x(9);
matrix_B(4,1) = x(10);
matrix_B(5,1) = x(11);
matrix_B(6,1) = x(12);

qDot            = x(7:12);
massMatrix      = mass6x6(x,parameters);
betaMatrix      = beta6x1(x,parameters);
lamdaMatrix     = Lamda2_J(x,parameters,footshape);
lamdaMatrixDot  = Lamda2_dot_J(x,parameters,footshape);


matrix_B(7:12,1)= massMatrix^(-1) * ( ...
                                	betaMatrix - lamdaMatrix * (lamdaMatrix'*massMatrix^(-1)*lamdaMatrix)^(-1) * (lamdaMatrixDot'*qDot + lamdaMatrix'*massMatrix^(-1)*betaMatrix)...
                                    );

end

