clear
T=2e-3;  % set period to its value
wo=2*pi/T;  % compute the fundamental frequency
RC=0.3e-3;   % set the RC value for the circuit
k=-200:200;  % create vector holding FS coefficient k index values (-200 to 200 rather than -inf to inf!!!)
f_max = max(k)*wo/(2*pi);  % find max frequency of the FS components
Fs = 2.3*f_max; Ts = 1/Fs;  % choose Fs higher than 2*f_max…. 2.3 factor is suitable.
t=-3*T:Ts:3*T;   % create a vector of time points range of -3T to 3T with appropriate spacing

ck=j*((-1).^k)./(pi*k);  % compute ck using formula for all k even though it only holds for odd!!!
ck(k==0)=1;   % index into k=0 position and set to value of 2

x=0;  % initialize to 0 to allow later adding of terms for the FS summation
for n=1:length(k)   % loop that adds terms to FS summation
    x = x + ck(n)*exp(j*k(n)*wo*t);   % each time through add a new term to the summation
end
x=real(x);  % theoretically imaginary parts should cancel... but due to rounding they don't so we keep only the real part


w=(-30*wo):10:(30*wo);  % create a set of frequency points for plotting H(w)
H_w=j*w*RC./(1 + j*w*RC);  % compute H(w) at these w values (finer grid than needed for computing d_k)

kwo=k*wo;  %define convenient variable
H_kwo=j*kwo*RC./(1 + j*kwo*RC);  % compute H(k*wo)...
dk=H_kwo.*ck;  % compute output signal's FS coefficients



y=0;  % setup for computing FS summation for output signal
for n=1:length(k)
    y = y + dk(n)*exp(j*k(n)*wo*t);
end
y=real(y);  % suppress small imaginary part that is due to numerical precision

subplot(3,2,1)   % create a 3x2 grid of subplots and point to the 1st element
plot(t/(1e-3),x)   % plot the signal computed via FS summation
set(gca,'Xtick',-6:6); xlim([-6 6])
xlabel('time (msec)')   %  ALWAYS lable axes!!!!
ylabel('x(t)')
title('Input Signal'); grid

subplot(3,2,2)   % point to 2nd plot in subplot grid
stem(k.*wo,abs(ck))  % stem plot of FS coefficients of input signal
xlabel('k\omega_o (rad/sec)'); ylabel('|c_k|')
axis([-30*wo 30*wo 0 1.1])   % set the range of the axes...
title('FS Magnitude Spectrum of Input Signal'); grid

subplot(3,2,4)
plot(w,abs(H_w))   % plot magnitude of frequency response
xlabel('\omega (rad/sec)'); ylabel('|H(\omega)|')
axis([-30*wo 30*wo 0 1.2])  %Set range of axes
title('Magnitude of Frequency Response of Circuit'); grid

subplot(3,2,5)
plot(t/(1e-3),y)  % plot output signal
set(gca,'Xtick',-6:6)
xlim([-6 6]); xlabel('time (msec)'); ylabel('y(t)')
title('Output Signal'); grid

subplot(3,2,6)
stem(k.*wo,abs(dk))   % plot FS magnitude spectrum for output signal
xlabel('k\omega_o (rad/sec)'); ylabel('|d_k|')
axis([-30*wo 30*wo 0 1.1])
title('FS Magnitude Spectrum of Input Signal'); grid
