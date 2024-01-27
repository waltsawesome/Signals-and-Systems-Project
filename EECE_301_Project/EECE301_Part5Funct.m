function [a,b] = EECE301_Part5Funct(rz,rp,theta)
%Takes Radius and Angle values and converts to polynomial coefficients
%   Detailed explanation goes here

%Real part of the root
real=rp*cos(theta);
%Imaginary part of the root
imag=rp*sin(theta)*1i;
%poly() returns polynomial coefficients from roots
a=poly([real+imag real-imag]);
real=rz*cos(theta);
%Imaginary part of the root
imag=rz*sin(theta)*1i;
b=poly([real+imag real-imag]);
end