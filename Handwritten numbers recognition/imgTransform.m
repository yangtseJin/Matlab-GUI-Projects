function [] = imgTransform()
%将手写图像转换为二值图，与mnist数据集像素一致
for i=0:9
    RGB = imread(fullfile('./my_handwriting',strcat(num2str(i),'.bmp')));%将图像读入工作区
    a = im2gray(RGB);     
    b=255-a;
    c=im2bw(b,0.5);
    imwrite(c,strcat(num2str(i),'.bmp'));
end

