function footshape= create_footshape(foot_center_angle,radius,name)

% foot_center_angle=20.9820;
% theta=-foot_center_angle*pi/180:1*pi/180:foot_center_angle*pi/180;
theta=linspace(-foot_center_angle*pi/180, foot_center_angle*pi/180, 100);
% radius=0.1092;
xdata=radius*sin(theta);
ydata=-radius*cos(theta);

% Generate (x, y) data based on the ankle's location
xdata=xdata-min(xdata);
ydata=ydata-max(ydata);

p = polyfit(xdata,ydata,7);
x = linspace(min(xdata),max(xdata),1000);
y = polyval(p,x);

% Generate phi foot angles
fis=atan2(y,x);

% Calculate gama angles 
thetas0=atan(diff(y)./diff(x));

% Set x, y coordinates based on the gama angle calculation points
x_thetas0=x(1:end-1)+diff(x)/2;
y_thetas0=y(1:end-1)+diff(y)/2;

% Set gama angle to values from -pi/2 to pi/2
thetas1=[-pi/2:mean(abs(diff(thetas0))):min(thetas0),thetas0,max(thetas0):mean(abs(diff(thetas0))):pi/2];
x_thetas1=[ones(size(-pi/2:mean(abs(diff(thetas0))):min(thetas0)))*x_thetas0(1),x_thetas0,ones(size(max(thetas0):mean(abs(diff(thetas0))):pi/2))*x_thetas0(end)];
y_thetas1=[ones(size(-pi/2:mean(abs(diff(thetas0))):min(thetas0)))*y_thetas0(1),y_thetas0,ones(size(max(thetas0):mean(abs(diff(thetas0))):pi/2))*y_thetas0(end)];

% Set the point vectors to be unique
[thetas, index] = unique(thetas1); 
x_thetas = x_thetas1(index);
y_thetas = y_thetas1(index);

% Generate data for the second foot
psis=-thetas;
x_psis=x_thetas;
y_psis=y_thetas;

% Calculate dx/dgama , dy/dgama
dx_dthetas=diff(x_thetas)./diff(thetas);
dy_dthetas=diff(y_thetas)./diff(thetas);
dx_dpsis=diff(x_psis)./diff(psis);
dy_dpsis=diff(y_psis)./diff(psis);

% Set dx/dgama gama calculation points
thetas_dxy_dth=thetas(1:end-1)+diff(thetas)/2;
psis_dxy_dps=psis(1:end-1)+diff(psis)/2;

% Interpolate x and y coordinate on the new gama points
theta_vector=thetas_dxy_dth;
psi_vector=psis_dxy_dps;
x_vector=interp1(thetas,x_thetas,theta_vector,'linear');    % x coordinates
y_vector=interp1(thetas,y_thetas,theta_vector,'linear');    % y coordinates
fi_vector=interp1(x,fis,x_vector,'linear');                 % phi coordinates
dx_dth_vector=dx_dthetas;                                   % dx/dgama
dy_dth_vector=dy_dthetas;                                   % dy/dgame
dx_dps_vector=dx_dpsis;                                     % dx/dgama (for the second foot)
dy_dps_vector=dy_dpsis;                                     % dy/dgama (for the second foot)

% Calculate dx_ankle/dgama and dy_ankle/dgama (x, y ankle at plane 1) 
dxc1_dth=sqrt((dx_dth_vector).^2+(dy_dth_vector).^2)+...                                                                                            % Radius (from rolling contact)
    -cos(theta_vector-fi_vector)/2.*(2*x_vector.*dx_dth_vector+2*y_vector.*dy_dth_vector)./sqrt(x_vector.^2+y_vector.^2)+...                        % drc/dgama * cos(gama - phi)
    +sin(theta_vector-fi_vector).*sqrt(x_vector.^2+y_vector.^2).*(1-(dy_dth_vector.*x_vector-dx_dth_vector.*y_vector)./(x_vector.^2+y_vector.^2));  % sin(gama-fi) * rc * (1 - dphi/dgama)

dyc1_dth=sin(theta_vector-fi_vector)/2.*(2*x_vector.*dx_dth_vector+2*y_vector.*dy_dth_vector)./sqrt(x_vector.^2+y_vector.^2)+...
    +cos(theta_vector-fi_vector).*sqrt(x_vector.^2+y_vector.^2).*(1-(dy_dth_vector.*x_vector-dx_dth_vector.*y_vector)./(x_vector.^2+y_vector.^2));

dxc2_dps=-sqrt((dx_dps_vector).^2+(dy_dps_vector).^2)+...
    -cos(-fi_vector-psi_vector)/2.*(2*x_vector.*dx_dps_vector+2*y_vector.*dy_dps_vector)./sqrt(x_vector.^2+y_vector.^2)+...
    +sin(-psi_vector-fi_vector).*sqrt(x_vector.^2+y_vector.^2).*(-1-(dy_dps_vector.*x_vector-dx_dps_vector.*y_vector)./(x_vector.^2+y_vector.^2));

dyc2_dps=sin(-psi_vector-fi_vector)/2.*(2*x_vector.*dx_dps_vector+2*y_vector.*dy_dps_vector)./sqrt(x_vector.^2+y_vector.^2)+...
    +cos(-psi_vector-fi_vector).*sqrt(x_vector.^2+y_vector.^2).*(-1-(dy_dps_vector.*x_vector-dx_dps_vector.*y_vector)./(x_vector.^2+y_vector.^2));

% Calculate second derivative of gama
ddx_ddth=diff(dx_dth_vector)./diff(theta_vector);
ddy_ddth=diff(dy_dth_vector)./diff(theta_vector);

% (This will be used to create jacobian constraint matrix !!!)  
ddxc1_ddth=diff(dxc1_dth)./diff(theta_vector);
ddyc1_ddth=diff(dyc1_dth)./diff(theta_vector);

ddxc2_ddps=diff(dxc2_dps)./diff(psi_vector);
ddyc2_ddps=diff(dyc2_dps)./diff(psi_vector);

% Calculate the gamas of differentiation
thetas_ddc_ddth=theta_vector(1:end-1)+diff(theta_vector)/2;
psis_ddc_ddth=psi_vector(1:end-1)+diff(psi_vector)/2;

% Interpolate all the results based on the gamas of the second defferentiation
footshape.theta=thetas_ddc_ddth;
footshape.psi=psis_ddc_ddth;
footshape.x=interp1(theta_vector,x_vector,thetas_ddc_ddth,'linear');
footshape.y=interp1(theta_vector,y_vector,thetas_ddc_ddth,'linear');
footshape.fi=interp1(theta_vector,fi_vector,thetas_ddc_ddth,'linear');

footshape.dx_dth=interp1(theta_vector,dx_dth_vector,thetas_ddc_ddth,'linear');
footshape.dy_dth=interp1(theta_vector,dy_dth_vector,thetas_ddc_ddth,'linear');
footshape.dx_dps=interp1(theta_vector,dx_dps_vector,thetas_ddc_ddth,'linear');
footshape.dy_dps=interp1(theta_vector,dy_dps_vector,thetas_ddc_ddth,'linear');

footshape.ddx_ddth=ddx_ddth;
footshape.ddy_ddth=ddy_ddth;

footshape.dc1x_dth=interp1(theta_vector,dxc1_dth,thetas_ddc_ddth,'linear');
footshape.dc1y_dth=interp1(theta_vector,dyc1_dth,thetas_ddc_ddth,'linear');
footshape.dc2x_dps=interp1(theta_vector,dxc2_dps,thetas_ddc_ddth,'linear');
footshape.dc2y_dps=interp1(theta_vector,dyc2_dps,thetas_ddc_ddth,'linear');

footshape.ddxc1_ddth=ddxc1_ddth;
footshape.ddyc1_ddth=ddyc1_ddth;
footshape.ddxc2_ddps=ddxc2_ddps;
footshape.ddyc2_ddps=ddyc2_ddps;

footshape.r=sqrt((footshape.x).^2+(footshape.y).^2);

footshape.curv=abs(((footshape.dx_dth.^2+footshape.dy_dth.^2).^(3/2))./(footshape.dx_dth.*footshape.ddy_ddth-footshape.ddx_ddth.*footshape.dy_dth));

end

