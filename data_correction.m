T=meas.Time;
I=meas.Current;
V=meas.Voltage;
Ah=meas.Ah;

for i=2:length(T)
    if T(i)==T(i-1)
        T(i)=T(i)+0.0001;
    end
end
Ti=ones(10,1);
Ti(1)=T(1);
    for i = 1:length(T)
        SOC=((Ah(i)+2.9)/2.9)*100;
        if SOC >= 90
          Ti(2)=T(i);
        elseif SOC >= 80
            Ti(3)=T(i);
        elseif SOC >= 70
             Ti(4)=T(i);
        elseif SOC >= 60
             Ti(5)=T(i);
        elseif SOC >= 50
             Ti(6)=T(i);
        elseif SOC >= 40
            Ti(7)=T(i);
        elseif SOC >= 30
             Ti(8)=T(i);
        elseif SOC >= 20
           Ti(9)=T(i);
        elseif SOC >= 10
             Ti(10)=T(i);
       
        end
    end
 T_e=T(end);
 SOC_1=((meas.Ah+2.9)/2.9);
 Tempera=meas.Battery_Temp_degC+273;
