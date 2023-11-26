function[w,b,w_h,b_h]=training(train_img,train_label)
%train function:设置一个隐藏层，784-->隐藏层神经元个数-->10
%train_img:训练样本的像素数据
%train_label：训练样本的标签
%w：输出层权重
%b：输出层偏置
%w_h：隐藏层权重
%b_h：隐藏层偏置
%step：循环步数

step=input('迭代步数：');
a=input('学习因子：');
in = 784; %输入神经元个数
hid = input('隐藏层神经元个数：');%隐藏层神经元个数
out = 10; %输出层神经元个数
o =1;

w = randn(out,hid);
b = randn(out,1);
w_h =randn(hid,in);
b_h = randn(hid,1);


for i=0:step
    %打乱训练样本
    r=randperm(3000);
    train_img = train_img(:,r);
    train_label= train_label(:,r);

    for j=1:3000
        x = train_img(:,j);
        y = train_label(:,j);

        hid_put = layerout(w_h,b_h,x);
        out_put = layerout(w,b,hid_put);

        %更新公式的实现
        o_update = (y-out_put).*out_put.*(1-out_put);
        h_update = ((w')*o_update).*hid_put.*(1-hid_put);

        outw_update = a*(o_update*(hid_put'));
        outb_update = a*o_update;
        hidw_update = a*(h_update*(x'));
        hidb_update = a*h_update;

        w = w + outw_update;
        b = b+ outb_update;
        w_h = w_h +hidw_update;
        b_h =b_h +hidb_update;
    end
end  
end