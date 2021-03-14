

    clear all
    clc
    
    serial = serialport('COM3',9600);
    
    fopen(serial);

    data = read(data,16,"uint32"); 
    x=linspace(1,1000);
       
    for i=1:length(x)
    	y(i)=fscanf(data,'%d');
    end
    	
     fclose(data);
    
     disp('making plot..')
     plot(x,y);