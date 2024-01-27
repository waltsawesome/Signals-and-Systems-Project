% USAGE: NS_21_Close_Sinusoids(N)
% 
% Inputs:  N = number of samples collected
%          N_zp = integer specifying DFT length including zero padding
%
% Outputs: Various plots of results... no returned values


%%% Set Collection Length if user does not specify

        N = 230;     % set collection length in samples
        N_zp=5*N;   % This sets N_zp to zero-pad out to 5 times the data length... a good rough rule for *THIS* application




Fs=4000;   % Set the sampling rate
T=1/Fs;    % Set the sample spacing

%%%  Create sum of sinusoids with frequencies of 1000 and 1011 Hz
x=cos(2*pi*1000*(0:(N-1))*T) + cos(2*pi*1011*(0:(N-1))*T);

t=(0:(N-1))*T;  % create a time vector that is the same length as the signal


X=fftshift(fft(x,N_zp));   
% the N_zp inside the fft command sets the length *including* zero-padding 


Omega=(-(N_zp/2):((N_zp/2)-1))*2*pi/N_zp;  %% DT Frequency... -pi to pi

f=(Fs/2)*(Omega/pi);   %%%  Convert into equivalent Hz values

h=plot(f,abs(X));
set(h,'linewidth',2)
set(gca,'fontsize',12)
xlabel('f  (Hz)')
ylabel('|X_{rx}[k]|')
grid

