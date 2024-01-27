function [xVectorEl] = xElegxos4x1(x,k,parametersModel)

    xVectorEl   = zeros(14,1);

    parameters  = parametersModel;
    footshape   = parametersModel.footshape;
    
    if k==1
        gravtor = SSP1_GravComp(x,parameters,footshape);
    elseif k==2
        gravtor = SSP2_GravComp(x,parameters,footshape);
    end
    
    xVectorEl(1)    = 0;
    xVectorEl(2)    = 0;
    xVectorEl(3)    = 0;
    xVectorEl(4)    = 0;
    xVectorEl(5)    = 0;
    xVectorEl(6)    = 0;
    xVectorEl(7)    = 0;
    xVectorEl(8)    = 0;
    xVectorEl(9)    = gravtor(1);
    xVectorEl(10)   = gravtor(2);
    xVectorEl(11)   = gravtor(3);
    xVectorEl(12)   = gravtor(4);
    xVectorEl(13)   = 0;
    xVectorEl(14)   = 0;

end