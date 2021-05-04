clear all
clc

%% serial comunication

COM="COM4";
reclength=1:1:600; %record length
serial=serialport(COM(1),9600); %open serial port for comunication with arduino

for i=1:length(reclength)
    data(i)=readline(serial);
    ppgsignal(i)=str2double(data(i));
end

%% signal processing

ppgsignal=normalize(ppgsignal);
ppgsignal=ppgsignal(20:length(reclength));

fs=190;
T=1/fs;
L=length(ppgsignal);
time=(0:L-1)*T;
f = fs*(0:(L/2))/L;

[pks,locs]=findpeaks(ppgsignal,time);
period=max(diff(locs));
%% fft

Y = fft(ppgsignal);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%% calculating BPM

[row, col] = find(ismember(P1, max(P1(:))));
freq=f(row,col)
BPM=f(row,col)*60

for n=1:(length(locs)-1)
    periode(n)=locs(n+1)-locs(n)
      
end  





%% ploting data

disp('making plot...')
subplot(3,1,1)
plot(time,ppgsignal);
title('PPG signal')
xlabel('t (s)')
ylabel('A')

subplot(3,1,2)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

subplot(3,1,3)
histogram(periode)

