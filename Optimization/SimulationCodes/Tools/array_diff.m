function [df_dx,ddf_ddx] = array_diff(f,x)
%% array_int 
% Description:  This function calculates the first and the second derivative of a function f(x) where x is an independent variable.
% 
% Inputs:       x:          double vector of the independent variable x
%
%               f:          double vector of the values that the function f give when is called at the x vector.
%
% Outputs:      df_dx:      double vector of the first derivative of function f
%               
%               ddf_ddx:    double vector of the first derivative of function f
%               
% Author: Antonios Kantounias, Email: antonis.kantounias@gmail.com

%% First gradient
df_dx = zeros(1,length(x));

% Front differentiation for the first vector instance
dx12 = x(2)-x(1);
dx13 = x(3)-x(1);
k = -(dx12 + dx13)/(dx12*dx13);
l = -dx13/(dx12*(dx12 - dx13));
m = dx12/(- dx13^2 + dx12*dx13);
df_dx(1) = k*f(1)+l*f(2)+m*f(3);

% Middle differentiation for the second  vector instance
for n = 2:length(x)-1
    dx12 = x(n)-x(n-1);
    dx23 = x(n+1)-x(n);
    k = -dx23/(dx12*(dx12 + dx23));
    l = -(dx12 - dx23)/(dx12*dx23);
    m = dx12/(dx23^2 + dx12*dx23);
    df_dx(n) = k*f(n-1)+l*f(n)+m*f(n+1);
end

% Back differentiation final vector instance
dx23 = x(end)-x(end-1);
dx13 = x(end)-x(end-2);
k = dx23/(dx13*(dx13 - dx23));
l = -dx13/(dx23*(dx13 - dx23));
m = (dx13 + dx23)/(dx13*dx23);
df_dx(end) = k*f(end-2)+l*f(end-1)+m*f(end) ; 

%% Secend gradient
ddf_ddx = zeros(1,length(x));

% Front differentiation
dx12 = x(2)-x(1);
dx13 = x(3)-x(1);
k = 2/(dx12*dx13);
l = 2/(dx12*(dx12 - dx13));
m = -2/(- dx13^2 + dx12*dx13);
ddf_ddx(1) = k*f(1)+l*f(2)+m*f(3);

% Middle differentiation
for n = 2:length(x)-1
    dx12 = x(n)-x(n-1);
    dx23 = x(n+1)-x(n);
    k = 2/(dx12*(dx12 + dx23));
    l = -2/(dx12*dx23);
    m = 2/(dx23^2 + dx12*dx23);
    ddf_ddx(n) = k*f(n-1)+l*f(n)+m*f(n+1);
end

%back differentiation
dx23 = x(end)-x(end-1);
dx13 = x(end)-x(end-2);
k = 2/(dx13*(dx13 - dx23));
l = -2/(dx23*(dx13 - dx23));
m = 2/(dx13*dx23);
ddf_ddx(end) = k*f(end-2)+l*f(end-1)+m*f(end); 
end
