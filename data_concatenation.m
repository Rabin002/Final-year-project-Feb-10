Voltage_all=[Voltage_all;meas.Voltage];
Current_all=[Current_all;-1*meas.Current];
SOC=((meas.Ah+2.9)/2.9);
SOC_all=[SOC_all;SOC];
Battery_Temp_K=meas.Battery_Temp_degC+273;
Temperature_all=[Temperature_all;Battery_Temp_K];
temp=extractTimetable(CC);
temp1=seconds(temp.Time);
temp2=temp.Coulomb;
for i=1:length(T)
    SOC_C=[SOC_C;interp1(temp1,temp2,T(i),"linear","extrap")];
end