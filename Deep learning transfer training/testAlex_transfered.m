clear all;
clc;
%%���Ժ���
%���ļ�������קͼƬ������Ϊfig�����������½ű�
%ֻ��һ����Ҫ�޸ĵĲ�����net�ļ�

%װ��net�ļ�
load('AlexNet_TransferLearning');
image_val = imresize(imread('./����ͼƬ/�ҵĿյ�2.jpg'),[227,227]);
[label,conf] = classify(net,image_val);
imshow(image_val);
title(sprintf('%s %.2f',char(label),max(conf)));