% Convert input and target data to table format
inputsTable = array2table(input_all);
targetsTable = array2table(SOC_all);

% Combine input and target data into a single table
data = [inputsTable, targetsTable];

% Specify the percentage for training, validation, and testing
trainPercentage = 70; % 70% for training
valPercentage = 15;   % 15% for validation
testPercentage = 15;  % 15% for testing

% Randomly partition the data into training, validation, and testing sets
c = cvpartition(size(data, 1), 'HoldOut', 1 - trainPercentage / 100);
idxTrain = training(c);
idxValTest = test(c);

% Split the remaining data into validation and testing sets
valTestSet = data(~idxTrain,:);
c = cvpartition(size(valTestSet, 1), 'HoldOut', valPercentage / 100);
idxVal = training(c);
idxTest = test(c);

% Create training, validation, and testing sets
trainData = data(idxTrain,:);
valData = valTestSet(idxVal,:);
testData = valTestSet(idxTest,:);


% Define the layers of the network
layers = [
    featureInputLayer(size(input_all,2),'Normalization','zscore','Name','input')
    fullyConnectedLayer(64,'Name','fc1')
    sigmoidLayer('Name','sigmoid1')
    fullyConnectedLayer(64,'Name','fc2')
    tanhLayer('Name','tanh1')
    fullyConnectedLayer(64,'Name','fc3')
    tanhLayer('Name','tanh2')
    fullyConnectedLayer(1,'Name','output')
    regressionLayer('Name','outputLayer')
];


% Specify the training options
options = trainingOptions('adam', ...
    'MaxEpochs',1000, ...
    'MiniBatchSize',64, ...
    'ValidationData',valData, ...
    'ValidationFrequency',100, ...
    'Verbose',true, ...
    'Plots','training-progress');

% Train the neural network
net = trainNetwork(trainData,layers,options);

% Evaluate the network on the test set
predictions = predict(net,testData(:,1:end-1));
performance_test = mean((predictions - testData.SOC_all).^2);
disp(['Test Performance: ', num2str(performance_test)]);
