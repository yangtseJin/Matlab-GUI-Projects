clear all;
clc;
%%测试函数
%向本文件夹内拖拽图片，命名为fig即可运行如下脚本
%只有一个需要修改的参数：net文件

%装载net文件
load('AlexNet_TransferLearning');
image_val = imresize(imread('./测试图片/我的空调2.jpg'),[227,227]);
[label,conf] = classify(net,image_val);
imshow(image_val);
title(sprintf('%s %.2f',char(label),max(conf)));