%R0_SOC=ones(10,5);
%R1_SOC=ones(10,5);
%C1_SOC=ones(10,5);
%tau1_SOC=ones(10,5);
%OCV_SOC=ones(10,5);
%j=10; 
for i=1:10
R1_SOC(i,5)=R1(i);
C1_SOC(i,5)=C1(i);
R0_SOC(i,5)=R0(i);
tau1_SOC(i,5)=R1(i)*C1(i);
OCV_SOC(i,5)=OCV(i);

%j=j-1;
end