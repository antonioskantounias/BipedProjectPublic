function [ x,y ] = rotate_coord( x1,y1,theta )
%coordinate transform for rotation of plane x1 y1 about the origin by theta rad
x=x1.*cos(theta)-y1.*sin(theta);
y=x1.*sin(theta)+y1.*cos(theta);

end

