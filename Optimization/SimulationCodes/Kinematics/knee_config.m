function [xA1,yA1,xA2,yA2,xA3,yA3,xA4,yA4] = knee_config(ksiF,L1F,l1,l2,l3,l4,l5,l6,thetaK,thetaF,xH,yH)

A2A4=sqrt(l4^2+l3^2-2*l3*l4*cos(thetaK));
angle_temp_f=atan2(l4*sin(thetaK),(l3-l4*cos(thetaK)));
angle_temp_b=acos((l1^2+A2A4.^2-l2^2)/2/l1./A2A4);

xU=xH+L1F*sin(thetaF);
yU=yH-L1F*cos(thetaF);
xA2=xU+(l3-l6)*cos(thetaF+ksiF-pi/2);
yA2=yU+(l3-l6)*sin(thetaF+ksiF-pi/2);
xA4=xA2+A2A4.*cos(thetaF+pi/2+ksiF+angle_temp_f);
yA4=yA2+A2A4.*sin(thetaF+pi/2+ksiF+angle_temp_f);
%
xA1=xA4+l1*cos(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);
yA1=yA4+l1*sin(thetaF+ksiF+angle_temp_f+angle_temp_b-pi/2);

xA3=xU-l6*cos(thetaF+ksiF-pi/2);
yA3=yU-l6*sin(thetaF+ksiF-pi/2);


end

