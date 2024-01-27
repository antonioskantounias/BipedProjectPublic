function [F] = array_int(f,x,F0)
%% array_int 
% Description:  This function calculates the antiderivative of a function f(x) where x is an independent variable.
% 
% Inputs:       x:  double vector of the independent variable x
%
%               f:  double vector of the values that the function f give when is called at the x vector.
%
%               FO: double initial value of the antiderivative
%
% Outputs:      F:  double vector of the antiderivative of function f
%
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% Calculation of the integral with trapezium method
% Initialize the antiderivative
F       = zeros(1,length(x));
F(1)    = F0; 

% Apply the trapezioum method iteratively
for n = 2:length(x)
    F(n) = F(n-1) + (x(n) - x(n-1)) * (f(n) + f(n-1)) / 2;
end

end
