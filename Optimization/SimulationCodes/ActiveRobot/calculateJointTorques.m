function [torqueVector, powerVector, energyVector] = calculateJointTorques(simulationParameters, results)

parametersModel = simulationParameters.Model;

numOfTSteps     = length(results.t);
torqueVector    = zeros(numOfTSteps,4);
powerVector     = zeros(numOfTSteps,4);
energyVector    = zeros(numOfTSteps,4);

for iTStep = 1 : numOfTSteps
    % Export states
    x = zeros(14,1);
    x(1)=results.xH(iTStep);
    x(2)=results.yH(iTStep);
    x(3)=results.thetaF(iTStep);
    x(4)=results.thetaK(iTStep);
    x(5)=results.psiF(iTStep);
    x(6)=results.psiK(iTStep);
    
    x(7)=results.xH_d(iTStep);
    x(8)=results.yH_d(iTStep);
    x(9)=results.thetaF_d(iTStep);
    x(10)=results.thetaK_d(iTStep);
    x(11)=results.psiF_d(iTStep);
    x(12)=results.psiK_d(iTStep);
    
    phase = results.phase(iTStep);
    
    torqueElegxos = Elegxos4x1(x,phase,parametersModel);
    % In case the nullity of the system is not 2 the torques are geting zeros.
    % Use the previous torque instead. 
        if ~any(torqueElegxos ~= 0)
            torque = torqueVector(iTStep-1,:); %torque = torqueElegxos;
        else
            torque = torqueElegxos;
        end
    
    power  = torque.*x(9:12)';
    torqueVector(iTStep,:) = torque;
    powerVector(iTStep,:) = power;
    powerTotVector(iTStep) = sum(power);
end

for iDof = 1 : 4
    energyVector(:,iDof) = array_int(powerVector(:,iDof),results.t,0);
end

