%% Intro
% Walter Schutz 
% EECE 301 Signals and Systems Part 2 Code
close all
clc
clear
%% Code
[Y, Fs] = audioread('g_note.wav'); % Same as part 1 code
Y=Y/max(Y);
%sound(Y,Fs); 
G_tvect=0:1/Fs:(length(Y)-1)/Fs; %Assume Fs is in Hz, divide by Fs to get seconds
t=G_tvect(1*Fs:round(1.03*Fs)+1); %index of values from time 0 to 30ms 
y=Y(1*Fs:round(1.03*Fs)+1);
K=10; 
k=-K:1:K;
f0=196;
T=1/Fs;   
wo=f0*2*pi;
ck = [.573 1 .149 .139 .030 .18 .158 .071 .071 .244];
ck = [flip(ck) 0 ck];
randPhase=pi*2*rand(1,K)-1;
ckphase = [flip(randPhase) 0 randPhase];
ckphase=ck.*exp(1i*ckphase);

x=0;
for n=1:length(k)   % loop that adds terms to FS summation
    x = x + ckphase(n)*exp(1i*k(n)*wo.*G_tvect);   % each time through add a new term to the summation
end
x=real(x);  % theoretically imaginary parts should cancel... but due to rounding they don't so we keep only the real part
x=x/max(abs(x));
x=x.*1.*exp(-3.2*G_tvect/5);
%% STAGE 1
%LOW PEAK
rz=.5;
rp=.8;
theta=pi/6;
[a1,b1] = EECE301_Part5Funct(rz,rp,theta);
%% STAGE 2
%HIGH NULL
rz=.6;
rp=.5;
theta=3*pi/4;
[a2,b2] = EECE301_Part5Funct(rz,rp,theta);
%% GENERATE RESULTS

N_zp=1*length(x);
YF=fft(x,N_zp);
[h1, wout1] = freqz(b1,a1,length(YF));
[h2, wout2] = freqz(b2,a2,length(YF));
YF_Filter=h1'.*YF;
YF_Filter=h2'.*YF_Filter;
Y_Filter = ifft(YF_Filter);
figure
h3=h1.*h2;
plot(wout1,abs(h1.*h2))
title('Frequency Response'); 
ylabel('H(\omega)')
xlabel('Angle (Radians)')
figure
subplot(2,1,1)
plot(G_tvect,x)
subplot(2,1,2)
plot(G_tvect, real(Y_Filter))
sound(Y,Fs);
pause(3)
sound(abs(Y_Filter),Fs) %filtered sound
pause(3)
sound(x,Fs) %generated sound
