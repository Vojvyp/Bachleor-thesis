clear all
clc

%% serial comunication

COM="COM4";
reclength=1:1:600; %record length
serial=serialport(COM(1),19200); %open serial port for comunication with arduino

for i=1:length(reclength)
    data(i)=readline(serial);
    ppgsignal(i)=str2double(data(i));
end

%% signal processing

ppgsignal=normalize(ppgsignal);
ppgsignal=ppgsignal(20:length(reclength));

fs=380;
T=1/fs;
L=length(ppgsignal);
time=(0:L-1)*T;
f = fs*(0:(L/2))/L;

for i=1:length(ppgsignal)
               if ppgsignal(i)>1.5
                   signal(i)=1;
               else
                   signal(i)=0;
               end
           end

[pks,locs]=findpeaks(signal,time);
locs
pks
period=(diff(locs))
freq2=1./period
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
    periode(n)=locs(n+1)-locs(n);
      
end  

% [x,harmpow,harmfreq] = thd(ppgsignal)
% 
% U1 =10^(harmpow(1)/20) 
% U2 =10^(harmpow(2)/20) 
% U3 =10^(harmpow(3)/20) 
% U4 =10^(harmpow(4)/20) 
% U5 =10^(harmpow(5)/20) 
% U6 =10^(harmpow(6)/20) 
% 
% a = U2^2+U3^2+U4^2+U5^3+U6^2;
% THD_N = (sqrt(a)/U1)*100


%% ploting data

disp('making plot...')
subplot(3,1,1)
plot(time,ppgsignal);
title('PPG signal')
xlabel('t (s)')
ylabel('{\Delta}p [Pa]')

subplot(3,1,2)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of S(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

% subplot(3,1,3)
% histogram(periode);

