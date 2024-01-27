%% Intro
% Walter Schutz 
% EECE 301 Signals and Systems
close all
clc
%% 1.1
[y, Fs] = audioread('g_note.wav'); % Make sure file is in same folder as program
%% 1.2
y=y/max(y);
sound(y,Fs); 
%% 1.3
subplot(2,1,1)
G_tvect=0:1/Fs:(length(y)-1)/Fs; %Assume Fs is in Hz, divide by Fs to get seconds
plot(G_tvect,y)
xlabel("Seconds");
ylabel("Magnitude");
subplot(2,1,2)
plot(G_tvect(Fs+1:round(1.03*Fs)+1),y(Fs+1:round(1.03*Fs)+1)) %Adding +1 because matlab is weird
xlabel("Seconds");
ylabel("Magnitude");
%% 1.4
figure
STime=[0 2 2.5 3 3.5 4.5]; % Start times for .03s Intervals
for i=1:length(STime)
   subplot(length(STime),1,i) % Put them in subplots
   % Multipling Seconds by Hz will give timevector index
   plot(G_tvect(round(STime(i)*Fs)+1:round((STime(i)+.03)*Fs)+1), ...
       y(round(STime(i)*Fs)+1:round((STime(i)+.03)*Fs)+1))
   xlabel("Seconds");
   ylabel("Magnitude");
   xlim([STime(i),STime(i)+.03]); 
   ylim([-1 1]) % To show magnitude
end
%% 1.5
figure
plot(G_tvect,log(abs(y)))
%-3/5 slope and -3.2 intercept 03.2e^(3/5*t)
figure
plot(G_tvect,y)
hold on
plot(G_tvect,exp(-3*G_tvect/5)) 

   xlabel("Seconds");
   ylabel("Magnitude");

