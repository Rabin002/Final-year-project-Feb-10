In=input_all;
T=SOC_all;
% Specify GPU device (optional, if you have multiple GPUs)
gpuDeviceID = 1; % Choose the GPU device ID (e.g., 1 for the first GPU)
gpuDevice(gpuDeviceID);
% Assuming you have a dataset with inputs (In) and targets (T)

% Specify the percentage for training, validation, and testing
trainPercentage = 70; % 70% for training
valPercentage = 15;   % 15% for validation
testPercentage = 15;  % 15% for testing

% Shuffle the indices of the dataset
rng('default');  % For reproducibility
indices = randperm(size(In, 1));

% Calculate the number of samples for each set
numTotalSamples = numel(indices);
numTrainSamples = round(trainPercentage / 100 * numTotalSamples);
numValSamples = round(valPercentage / 100 * numTotalSamples);
numTestSamples = round(testPercentage / 100 * numTotalSamples);

% Extract indices for training, validation, and testing sets
trainIndices = indices(1:numTrainSamples);
valIndices = indices(numTrainSamples + 1 : numTrainSamples + numValSamples);
testIndices = indices(numTrainSamples + numValSamples + 1 : end);

% Create training, validation, and testing sets
In_train = In(trainIndices, :);
T_train = T(trainIndices, :);

In_val = In(valIndices, :);
T_val = T(valIndices, :);

In_test = In(testIndices, :);
T_test = T(testIndices, :);

% Create and initialize the neural network
net = newff(minmax(In_train'), [3, 64,64, 1], {'logsig','tansig','tansig','purelin'}, 'trainlm');
net = init(net);
net.trainParam.show = 1;
net.trainParam.epochs =1000;
net.trainParam.goal = 1e-12;

% Train the network using the training set
net = train(net, In_train', T_train');

% Evaluate the network on the validation set
output_val = sim(net, In_val');

% Evaluate the performance on the validation set (you can add relevant evaluation metrics)
performance_val = perform(net, T_val', output_val);
disp(['Validation Performance: ', num2str(performance_val)]);

% Evaluate the network on the test set
output_test = sim(net, In_test');

% Evaluate the performance on the test set (you can add relevant evaluation metrics)
performance_test = perform(net, T_test', output_test);
disp(['Test Performance: ', num2str(performance_test)]);
