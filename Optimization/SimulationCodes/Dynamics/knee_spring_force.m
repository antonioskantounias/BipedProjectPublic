function [u] = knee_spring_force(x,param)

% Define the control scheme used for the biped
% Current scheme: gravity compensation control

xH=x(1);
yH=x(2);
thetaU = x(3);
thetaK = x(4);
psiU = x(5);
psiK = x(6);

xH_d = x(7);
yH_d =x(8);
thetaU_d = x(9);
thetaK_d = x(10);
psiU_d = x(11);
psiK_d = x(12);


knee_cap_angle = param.knee_cap_angle;
knees=[thetaK,psiK];
knees_cap=knees<=knee_cap_angle;

UthK=knees_cap(1)*(-param.k*(thetaK-knee_cap_angle) - param.b*thetaK_d);
UpsK=knees_cap(2)*(-param.k*(psiK  -knee_cap_angle) - param.b*psiK_d);

% plot(180/pi*thetaK,knees_cap(1)*(-param.KP*(thetaK-knee_cap_angle/180*pi)),'k.')
% hold on
% plot(180/pi*psiK,knees_cap(2)*(-param.KP*(psiK  -knee_cap_angle/180*pi)),'b.')
% drawnow
u=[0,0,0,UthK, 0 , UpsK]';

end

