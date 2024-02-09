In=input_all';
T=SOC_all';
net=newff(minmax(In),[3,10,10,10,10,1],{'logsig','tansig','tansig','tansig','tansig','purelin'},'trainlm');
net=init(net);
net.trainParam.show=1;
net.trainParam.epochs=5000;
net.trainParam.goal=1e-12;
net=train(net,In,T);
