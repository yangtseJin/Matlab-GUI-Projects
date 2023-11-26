function [] = testSingleImage(img,w,b,w_h,b_h)
%测试单张图片的结果
%img为读取的单张图片
%probability为预测结果的概率
%result为预测识别的结果
img=double(img);
img=reshape(img,784,1);  %将读入的图像像素化，变成784*1的矩阵
test=zeros(10,1);
hid = layerout(w_h,b_h,img);  
test=layerout(w,b,hid);
[probability,result]=max(test);
fprintf('识别结果为：%d\n',result-1);
fprintf('概率为:%d\n',probability);
end

