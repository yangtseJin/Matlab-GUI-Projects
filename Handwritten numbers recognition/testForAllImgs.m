function[]= testForAllImgs(test_img,test_label,w,b,w_h,b_h)
%train_img:测试样本的像素数据
%train_label：测试样本的标签
%w：输出层权重
%b：输出层偏置
%w_h：隐藏层权重
%b_h：隐藏层偏置

test = zeros(10,1000);
for k=1:1000
    temp_img = test_img(:,k);

    hid = layerout(w_h,b_h,temp_img);
    test(:,k)=layerout(w,b,hid);

    %正确率表示方式一：输出正确个数的比例
    [t,t_index]=max(test);
    [label,label_index]=max(test_label);
    sum = 0;
    for p=1:length(t_index)
        if t_index(p)==label_index(p)
            sum =sum+1;
        end
    end
end

fprintf('正确率: %d/1000\n',sum);

%正确率表示方式二：用plotconfusion函数
plotconfusion(test_label,test);
end
