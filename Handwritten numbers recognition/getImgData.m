function[train_img,train_label,test_img,test_label]=getImgData()
%读取mnist数据集的图片
%把图片变成像素矩阵
%train_img:训练样本像素矩阵(784,4000)
%train_label:训练样本标签(10,4000)
%test_img:测试样本像素矩阵(784,1000)
%test_label:测试样本标签(10,1000)

train_img=[];
data=zeros(10,4000);

for n=0:399      
    for m=0:9
     temp=imread(fullfile('./mnistdata',strcat(num2str(m),'_',num2str(n),'.bmp')));   %文件操作将.bmp图像读成像素
     temp=double(temp);
     temp=reshape(temp,784,1);
     train_img=[train_img,temp];    %矩阵延拓到28*28 到一列 *n个图片
     data(m+1,10*n+m+1)=1;
end
end
test_img =[];
train_label =[];
test_label =[];
for n=400:499    
    for m=0:9
     temp=imread(fullfile('./mnistdata',strcat(num2str(m),'_',num2str(n),'.bmp')));   %文件操作将.bmp图像读成像素
     %''内为存储数据地址
      temp=double(temp);
      temp=reshape(temp,784,1);
      test_img=[test_img,temp];    %矩阵延拓到28*28 到一列 *n个图片
      data(m+1,10*n+m+1)=1;
    end
end

train_label=data(:,1:3000);
test_label = data(:,3001:4000);
train_img;
train_label;
test_img;
test_label;

end

