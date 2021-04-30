clear all
clc
COM = "COM4"
% x = linspace(100, 900, 1000);
x=1:1:600;                          % record length       
serial = serialport(COM(1),9600); % open serial port for comunication with arduino


for i=1:length(x)                 % read data and string transfer to double format
  data(i) = readline(serial);
  y(i)=str2double(data(i));     
end    
    
disp('making plot..')

y=y(20:length(x));
% x=x(20:length(x));
fs=187.86;
% fs=190;   % fs calculated from baudrate 9600/3 = 3200, 3 number of sent characters in serial communication 
T=1/fs;
L=length(y);
time = (0:L-1)*T;


ynorm=normalize(y);
[pks,locs] = findpeaks(y,time);




Y = fft(ynorm);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = fs*(0:(L/2))/L;
subplot(2,1,1);
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')


[row, col] = find(ismember(P1, max(P1(:))))% search max value in spectrum of ppg signal

BPM=f(row,col)*60 % calculate BPM

period = max(diff(locs))
freq =(1/period)
freqfft=f(row,col)

subplot(2,1,2);
plot(time,ynorm, 'r');
title('PPG signal')
xlabel('t (s)')
ylabel('A [-]')

