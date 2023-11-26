clear all;
clc;
%%迁移学习Alexnet
%只需修改一个参数：图像地址
%前提是装载了Deep Learning Toolbox和Alexnet
%图片必须经过预处理

%运算时间比较长，根据情况修改MaxEpoch


net = alexnet; %加载在ImageNet上预训练的网络模型
imageInputSize = [227 227 3];

%加载图像，修改预处理后的图像地址
allImages = imageDatastore('.\imgdata',...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');
    %划分训练集和验证集
 [training_set,validation_set] = splitEachLabel(allImages,0.7,'randomized');

 %由于原始网络全连接层1000个输出，显然不适用于我们的分类任务，因此在这里替换
layersTransfer = net.Layers(1:end-3);
categories(training_set.Labels)
numClasses = numel(categories(training_set.Labels));

%新的网络
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'Name', 'fc','WeightLearnRateFactor',1,'BiasLearnRateFactor',1)
    softmaxLayer('Name', 'softmax')
    classificationLayer('Name', 'classOutput')];

lgraph = layerGraph(layers);
plot(lgraph)
%对数据集进行扩增
augmented_training_set = augmentedImageSource(imageInputSize,training_set);

%'MaxEpochs' 即训练次数，根据需要调整
opts = trainingOptions('adam', ...
    'MiniBatchSize', 32,... % mini batch size, limited by GPU RAM, default 100 on Titan, 500 on P6000
    'InitialLearnRate', 1e-4,... % fixed learning rate
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.25,...
    'LearnRateDropPeriod',10,...
    'L2Regularization', 1e-4,... constraint
    'MaxEpochs',20,...
    'ExecutionEnvironment', 'gpu',...       //利用GPU训练，也可改为CPU训练
    'ValidationData', validation_set,...
    'ValidationFrequency',80,...
    'ValidationPatience',8,...
    'Plots', 'training-progress')

%训练
net = trainNetwork(augmented_training_set, lgraph, opts);

%保留训练出来的net网络，需要随后另存
save AlexNet_TransferLearning.mat net

%数据的可视化显示
[predLabels,predScores] = classify(net, validation_set);
plotconfusion(validation_set.Labels, predLabels)
PerItemAccuracy = mean(predLabels == validation_set.Labels);
title(['overall per image accuracy ',num2str(round(100*PerItemAccuracy)),'%'])
