clear all
clc
     
    serial=serialport('COM3',9600);
    x=1:1000;
    
    data = read(serial,max(x),"uint32");
%     fopen(data);
%      
%         
%     for i=1:length(x)
%     	y(i)=fscanf(data,'%d');
%     end
%     	
%     fclose(data);
%     
%     disp('making plot..')
    plot(x,data);