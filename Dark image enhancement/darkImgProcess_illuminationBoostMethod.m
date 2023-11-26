clear;
clc;

%   img: RGB Image
%   lambda: I3和I4转换中使用的参数
%img=im2double(imread('1.png'));
img=im2double(imread('./结果图片/工程院楼.jpg'));
lambda=5;
img = im2double(img);
I1 = (max(max(max(img))) ./ log(max(max(max(img))) + 1)) .* log(img + 1);
I2 = 1 - exp(-img);
I3 = (I1 + I2) ./ (lambda + (I1 .* I2));
I4 = erf(lambda * atan(exp(I3)) - 0.5 * I3);
I5 = (I4 - min(min(min(I4)))) ./ (max(max(max(I4))) - min(min(min(I4))));
figure;

subplot(1,2,1);  
imshow(img);  
xlabel('a). 原始图像');  
subplot(1,2,2);  
imshow(I5,[]);  
xlabel('b). 光照增强');  
imwrite(I5,"illuminationMethod_yl.png");