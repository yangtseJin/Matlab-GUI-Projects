clear all;
clc;
%%Ǩ��ѧϰAlexnet
%ֻ���޸�һ��������ͼ���ַ
%ǰ����װ����Deep Learning Toolbox��Alexnet
%ͼƬ���뾭��Ԥ����

%����ʱ��Ƚϳ�����������޸�MaxEpoch


net = alexnet; %������ImageNet��Ԥѵ��������ģ��
imageInputSize = [227 227 3];

%����ͼ���޸�Ԥ������ͼ���ַ
allImages = imageDatastore('.\imgdata',...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');
    %����ѵ��������֤��
 [training_set,validation_set] = splitEachLabel(allImages,0.7,'randomized');

 %����ԭʼ����ȫ���Ӳ�1000���������Ȼ�����������ǵķ�����������������滻
layersTransfer = net.Layers(1:end-3);
categories(training_set.Labels)
numClasses = numel(categories(training_set.Labels));

%�µ�����
layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'Name', 'fc','WeightLearnRateFactor',1,'BiasLearnRateFactor',1)
    softmaxLayer('Name', 'softmax')
    classificationLayer('Name', 'classOutput')];

lgraph = layerGraph(layers);
plot(lgraph)
%�����ݼ���������
augmented_training_set = augmentedImageSource(imageInputSize,training_set);

%'MaxEpochs' ��ѵ��������������Ҫ����
opts = trainingOptions('adam', ...
    'MiniBatchSize', 32,... % mini batch size, limited by GPU RAM, default 100 on Titan, 500 on P6000
    'InitialLearnRate', 1e-4,... % fixed learning rate
    'LearnRateSchedule','piecewise',...
    'LearnRateDropFactor',0.25,...
    'LearnRateDropPeriod',10,...
    'L2Regularization', 1e-4,... constraint
    'MaxEpochs',20,...
    'ExecutionEnvironment', 'gpu',...       //����GPUѵ����Ҳ�ɸ�ΪCPUѵ��
    'ValidationData', validation_set,...
    'ValidationFrequency',80,...
    'ValidationPatience',8,...
    'Plots', 'training-progress')

%ѵ��
net = trainNetwork(augmented_training_set, lgraph, opts);

%����ѵ��������net���磬��Ҫ������
save AlexNet_TransferLearning.mat net

%���ݵĿ��ӻ���ʾ
[predLabels,predScores] = classify(net, validation_set);
plotconfusion(validation_set.Labels, predLabels)
PerItemAccuracy = mean(predLabels == validation_set.Labels);
title(['overall per image accuracy ',num2str(round(100*PerItemAccuracy)),'%'])
