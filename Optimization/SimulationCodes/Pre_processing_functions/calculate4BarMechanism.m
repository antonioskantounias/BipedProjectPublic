function [FourBarMech] = calculate4BarMechanism(a,b,g,f)

% T1 = 0.2; T2 = 0.2; T3 = 0.2;
% 
% a = 1-T1/2-T2/2;
% b = 1-T1/2-T3/2;
% f = 1-T2/2-T3/2;
% 
% T1s = 1+f-(a+b);
% T2s = 1+b-(f+a);
% T3s = 1+a-(b+f);

%% Calculate T1, T2, T3, T4 variables
T1 = g + f - (a + b);
T2 = b + g - (a + f);
T3 = b + f - (a + g);

% Check what type is input link
if  T1 * T2 >= 0 && T3 >= 0
    inputLinkType   = 'Crank';

elseif T1*T2 < 0 && T3 < 0
    inputLinkType   = 'Rocker';
    
elseif T1*T2 >= 0 && T3 < 0
    inputLinkType = 'Rocker0';
    
elseif T1*T2 < 0 && T3 >= 0
    inputLinkType = 'RockerPI';
    
end

% Check of what type is output link
if  T2 <= 0 && T1*T3 <= 0
    outputLinkType = 'Crank';

elseif T2 > 0 && T1*T3 > 0
    outputLinkType = 'Rocker';
    
elseif T2 <= 0 && T1*T3 > 0
    outputLinkType = 'Rocker0';

    
elseif T2 > 0 && T1*T3 <= 0
    outputLinkType = 'RockerPI';
    
end

%% Calculate maximum and minimum theta and psi anlges
if ~(T3>0 && T2<0 && T1<0) 
    
    % If the linkage is not grashofs linkage
    if T2 > 0
        ThetaMin    = acos( ( (a+f)^2+g^2-b^2 )/( 2*(a+f)*g ));
        PsiMin      = pi - acos( (b^2+g^2-(a+f)^2)/(2*b*g) );
    elseif T2 <= 0 && T1>=0
        ThetaMin    = acos( ( a^2+g^2-(f-b)^2 )/( 2*a*g ) );
        PsiMin      = acos( ((f-b)^2+g^2-a^2)/(2*(f-b)*g) ) - pi;
    elseif T2 <= 0 && T1<0
        ThetaMin    = -acos( ((a-f)^2+g^2-b^2)/(2*(a-f)*g) );
        PsiMin      = acos( (b^2+g^2-(a-f)^2)/(2*b*g) ) - pi;
    end
    
    if T3 < 0
        ThetaMax    = acos( ( a^2+g^2-(b+f)^2 )/( 2*a*g ));
        PsiMax      = pi - acos( ((b+f)^2+g^2-a^2)/(2*(b+f)*g) );
    elseif T3>=0 && T1>=0
        ThetaMax    = acos( ( (f-a)^2+g^2-b^2 )/( 2*(f-a)*g )) + pi;
        PsiMax      = pi - acos( (b^2+g^2-(f-a)^2)/(2*b*g) );
    elseif T3>=0 && T1<0
        ThetaMax    = 2*pi - acos( (a^2 + g^2 - (b-f)^2)/(2*a*g) );
        PsiMax      =  pi + acos( (g^2 + (b-f)^2 - a^2)/(2*g*(b-f)) );
    end
    
else
    
    % If the linkage is grashofs linkage
    ThetaMin = 0;
    ThetaMax = 2*pi;
    PsiMin = 0;
    PsiMax = 2*pi;
end

%% Assign results to the link structure
FourBarMech.inputLinkType   = inputLinkType;
FourBarMech.outputLinkType  = outputLinkType;

FourBarMech.ThetaMin        = ThetaMin;
FourBarMech.ThetaMax        = ThetaMax;
FourBarMech.PsiMin          = PsiMin;
FourBarMech.PsiMax          = PsiMax;

end