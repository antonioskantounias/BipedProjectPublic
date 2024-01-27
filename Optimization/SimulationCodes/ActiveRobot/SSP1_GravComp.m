function gravtor = SSP1_GravComp(x,parameters,footshape)
%% SSP1_GravComp 
% Description: Compensation | Underactuated Robots see Valouxis Fotios diploma thesis (Chapter 5.6) 
% 
% Inputs: 	
%
% Outputs:  
%
% Author: Antonios Kantounias - Fotios Valouxis, Email: antonis.kantounias@gmail.com
    
% Calculate the jacobian of the constraints
L6x2=Lamda1_J(x,parameters,footshape);

% Calculate the transpose of the jacobian
LT2x6=L6x2.';

% Calculate the mass matrix
Matrix_M6x6=mass6x6(x,parameters);

% Calculate the inverse of the mass matrix
invM6x6=(Matrix_M6x6)\eye(6);

% Calculate the gravitation terms
Bg6x1=betaG6x1(x,parameters);

% Calcualate the matrix Anxn
Lst=L6x2*inv(LT2x6*invM6x6*L6x2)*LT2x6*invM6x6;
PinA=eye(6)-Lst;

% Find the null space of the matrix Anxn
NA=null(PinA);
if size(NA,2)~=2
    gravtor = zeros(1,4);
    return
end
% Null vectors of matrix Anxn
x1=NA(1:6,1);
x2=NA(1:6,2);

% Underactuated degrees of freedom
    % Gravitational terms
NB=Bg6x1(1:2);
    % Null vectors
xx1=NA(1:2,1);
xx2=NA(1:2,2);
NAA=[xx1,xx2];

% Find the the constants of the null vectors in order to compansate the underactuated DoFs
idioA=linsolve(NAA,NB);

% Find actuated terms based on the gravitational terms and the constants of the null vector
gravtor(1)=x1(3)*idioA(1)+x2(3)*idioA(2)-Bg6x1(3);
gravtor(2)=x1(4)*idioA(1)+x2(4)*idioA(2)-Bg6x1(4);
gravtor(3)=x1(5)*idioA(1)+x2(5)*idioA(2)-Bg6x1(5);
gravtor(4)=x1(6)*idioA(1)+x2(6)*idioA(2)-Bg6x1(6);

end