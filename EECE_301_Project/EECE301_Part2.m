%% Intro
% Walter Schutz 
% EECE 301 Signals and Systems Part 2 Code
close all
clc
clear
%% Code
[y, Fs] = audioread('g_note.wav'); % Same as part 1 code
y=y/max(y);
%sound(y,Fs); %Don't want to listen to this
G_tvect=0:1/Fs:(length(y)-1)/Fs; %Assume Fs is in Hz, divide by Fs to get seconds
t=G_tvect(1:round(.03*Fs)+1); %index of values from time 0 to 30ms 

K=10; %Given in problem
k=-K:1:K;
f0=748;
T=1/Fs;   
wo=f0*2*pi;

ck=1./abs(k);
ck(K+1)=0; %Set ck to 0 where k=0

x=0;
%The following lines are from EECE_301_NS_10_Problem.m in Unit II
for n=1:length(k)   % loop that adds terms to FS summation
    x = x + ck(n)*exp(1i*k(n)*wo*t);   % each time through add a new term to the summation
end
x=real(x);  % theoretically imaginary parts should cancel... but due to rounding they don't so we keep only the real part
N_zp=length(x)*10; %zero padding 
XF=fftshift(fft(x,N_zp)); 
Omega=(-(N_zp/2):((N_zp/2)-1))*2*pi/N_zp;  %% DT Frequency... -pi to pi
f=(Fs/2)*(Omega/pi); %Vector from -1 to 1
%% Plot Results
h=plot(f,abs(XF),'-o');
set(gca,'fontsize',12)
xlabel('f  (Hz)')
ylabel('|X_{rx}[k]|')
grid
title("FFT of Artifically Created Fourier Series")
%Peak Values are extracted and written in the report
