clear;
clc;

% img = imread('1.png');   %读取图片
img=imread('./结果图片/工程院楼.jpg');
v=10;
r=mat2gray(double(img));
S=log(1+v*r)/(log(v+1));
 
subplot(1,2,1);  
imshow(r);  
xlabel('a). 原始图像');  
subplot(1,2,2);  
imshow(S,[]);  
xlabel('b). 对数变换');  
% imwrite(S,"logMethod.png");
imwrite(S,"logMethod_yl.png");