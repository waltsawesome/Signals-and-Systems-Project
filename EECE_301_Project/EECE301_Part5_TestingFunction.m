%% Intro
% Walter Schutz 
% EECE 301 Signals and Systems Part 2 Code
close all
clc
clear
%% Code
rz=.1;
rp=.9;
theta=pi/4;
[a,b] = EECE301_Part5Funct(rz,rp,theta);
%w=-pi:.01:pi;
pts=1000;
[h, wout] = freqz(b,a);
subplot(2,2,1)
plot(wout,abs(h))
title(['Rz=',num2str(rz),' Rp=',num2str(rp),' Theta=' ,num2str(theta)]); 
ylabel('|H(\omega)|')
xlabel('Angle (Radians)')
xlim([0 pi])


rz=.1;
rp=.9;
theta=pi/6;
[a,b] = EECE301_Part5Funct(rz,rp,theta);

[h, wout] = freqz(b,a,pts);
subplot(2,2,2)
plot(wout,abs(h))
title(['Rz=',num2str(rz),' Rp=',num2str(rp),' Theta=' ,num2str(theta)]); 
ylabel('|H(\omega)|')
xlabel('Angle (Radians)')
xlim([0 pi])

rz=.8;
rp=.3;
theta=pi/4;
[a,b] = EECE301_Part5Funct(rz,rp,theta);

[h, wout] = freqz(b,a,pts);
subplot(2,2,3)
plot(wout,abs(h))
title(['Rz=',num2str(rz),' Rp=',num2str(rp),' Theta=' ,num2str(theta)]); 
ylabel('|H(\omega)|')
xlabel('Angle (Radians)')
xlim([0 pi])

rz=.0;
rp=.0;
theta=3*pi/4;
[a,b] = EECE301_Part5Funct(rz,rp,theta);

[h, wout] = freqz(b,a,pts);
subplot(2,2,4)
plot(wout,abs(h))
title(['Rz=',num2str(rz),' Rp=',num2str(rp),' Theta=' ,num2str(theta)]); 
ylabel('H(\omega)')
xlabel('Angle (Radians)')
xlim([0 pi])