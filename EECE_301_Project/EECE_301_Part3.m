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
%t=G_tvect(1*Fs:round(1.03*Fs)+1); %index of values from time 0 to 30ms 
y=Y(1*Fs:round(1.03*Fs)+1); % 30 ms interval from 1 to 1.

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
x=x.*-3.2.*exp(-.6*G_tvect);
plot(G_tvect,x)
sound(x,Fs)
N_zp=length(y)*10;

YF=fft(y,N_zp);
Omega=(-(N_zp/2):((N_zp/2)-1))*2*pi/N_zp;  %% DT Frequency... -pi to pi
f=(Fs/2)*(Omega/pi); % Cool but Omega/pi is just a vector of length(XF) from -1 to 1
logYF= 20*log10(YF(1:round(length(YF)/2)));
YF=YF(1:round(length(YF)/2));

figure
%Plot Multiples of fundamental frequency versus magnitude (dB)
i=plot(f(round(length(f)/2):end-1)./f0,abs(logYF),'-o');
ylabel('log|Y_{rx}[k]|')
%plot(f(round(length(f)/2):end-1)./f0,abs(XF),'-o');
set(gca,'fontsize',12)
xlabel('Multiples of Fundamental Frequency')
xlim([0 inf])
grid