

    clear all
    clc
     
    arduino1=serial('COM3','BaudRate',9600);
     
    fopen(arduino1);
     
    x=linspace(1,1000);
       
    for i=1:length(x)
    	y(i)=fscanf(arduino1,'%d');
    end
    	
    fclose(arduino1);
    
    disp('making plot..')
    plot(x,y);