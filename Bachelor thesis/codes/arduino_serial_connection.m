clear all
clc
COM = "COM3"
% x = linspace(100, 900, 1000);
x=1:1:300;                          % record length       
serial = serialport(COM(1),9600); % open serial port for comunication with arduino


for i=1:length(x)                 % read data and string transfer to double format
  data(i) = readline(serial);
  y(i)=str2double(data(i));     
end    
    
disp('making plot..')

y=y(20:length(x));
% fs=187.86;
fs=320;
T=1/fs;
L=length(y);
time = (0:L-1)*T;

[pks,locs] = findpeaks(y,time);
period = max(diff(locs))

freq =(1/period)
%y=y*0.0048876;
plot(time,y);