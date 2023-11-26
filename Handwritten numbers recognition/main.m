clear all;
clc;
close all;
[train_img,train_label,test_img,test_label]=getImgData();

%归一化处理
train_img = mapminmax(train_img,0,1);
test_img =mapminmax(test_img,0,1);

[w,b,w_h,b_h]=training(train_img,train_label);
fprintf('训练正确率:\n');
testForAllImgs(test_img,test_label,w,b,w_h,b_h);


