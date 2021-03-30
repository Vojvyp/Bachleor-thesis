clear all
clc

x=1:400;                          % record length       
serial = serialport("COM3",9600); % open serial port for comunication with arduino


for i=1:length(x)                 % read data and string transfer to double format
  data(i) = readline(serial);
  y(i)=str2double(data(i));     
end    
    
disp('making plot..')
plot(x,y);