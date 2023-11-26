clear;
clc;

% img=imread('1.png');
img=imread('./结果图片/工程院楼.jpg');
imgInv = imcomplement(img);
img_dehazeInv = imreducehaze(imgInv);
img_dehaze = imcomplement(img_dehazeInv);

subplot(1,2,1);  
imshow(img);  
xlabel('a). 原始图像');  
subplot(1,2,2);  
imshow(img_dehaze,[]);  
xlabel('b). 去雾方法增强');  
% imwrite(img_dehaze,"dehazeMethod.png");
imwrite(img_dehaze,"dehazeMethod_yl.png");