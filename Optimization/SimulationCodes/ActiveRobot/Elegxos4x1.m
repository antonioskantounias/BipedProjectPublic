function [vectorEl] = Elegxos4x1(x,k,parametersModel)

    parameters  = parametersModel;
    footshape   = parametersModel.footshape;
    
    if k==1
        gravtor = SSP1_GravComp(x,parameters,footshape);
    elseif k==2
        gravtor = SSP2_GravComp(x,parameters,footshape);
    end
    
    vectorEl(1)=gravtor(1);
    vectorEl(2)=gravtor(2);
    vectorEl(3)=gravtor(3);
    vectorEl(4)=gravtor(4);

end