function [matrix_B] = SSP_beta14x1(t,x,parameters)

matrix_B(1,1) = x(7);
matrix_B(2,1) = x(8);
matrix_B(3,1) = x(9);
matrix_B(4,1) = x(10);
matrix_B(5,1) = x(11);
matrix_B(6,1) = x(12);

matrix_B(7:12,1)=beta6x1(x,parameters);

matrix_B(13,1) = 0;
matrix_B(14,1) = 0;

end

