clear;
clc;
close all;
for i=1:20 %样本个数
    x(i)=pi*(i-1)/10;    %    生成x, x=π*(i-1)/10
    y(i)=(1+cos(x(i)))/2;     %   y=(1+cosx)/2
end
n=length(x);%样本个数
p=6; %隐层个数
w=rand(p,2);
wk=rand(1,p+1);
max_epoch=10000;%最大训练次数
error_goal=0.002;%均方误差
learning_rate=0.09;%学习速率
a(p+1)=-1;

%training
%此训练网络采取1-6-1的形式，即一个输入，6个隐层，1个输出
for epoch=1:max_epoch
    e=0;
    for i=1:n %样本个数
        var=[x(i);-1]; 
        neto=0;
        for j=1:p 
            neti(j)=w(j,1)*var(1)+w(j,2)*var(2);
            a(j)=1/(1+exp(-neti(j)));
            %隐层的激活函数采取sigmoid函数，f(x)=1/(1+exp(-x))
            neto=neto+wk(j)*a(j);
        end          
        neto=neto+wk(p+1)*(-1);
        t(i)=neto; %输出层的激活函数采取线性函数,f(x)=x
        de=(1/2)*(y(i)-t(i))*(y(i)-t(i));
        e=de+e;     
        dwk=learning_rate*(y(i)-t(i))*a; 
        for k=1:p
            dw(k,1:2)=learning_rate*(y(i)-t(i))*wk(k)*a(k)*(1-a(k))*var;       
        end   
        wk=wk+dwk; %从隐层到输出层权值的更新
        w=w+dw; %从输入层到隐层的权值的更新    
    end 
    error(epoch)=e;
    m(epoch)=epoch;    
    if(e<error_goal)            
       break;
    elseif(epoch==max_epoch)
        disp('在目前的迭代次数内不能逼近所给函数，请加大迭代次数')        
    end 
    fprintf("第%d次迭代\n",epoch);
end
%simulation
for i=1:n %样本个数
    var=[x(i);-1];  
    neto=0;
    for j=1:p
        neti(j)=w(j,1)*var(1)+w(j,2)*var(2);
        a(j)=1/(1+exp(-neti(j)));
        neto=neto+wk(j)*a(j);
    end  
    neto=neto+wk(p+1)*(-1);
    t(i)=neto; %线性函数
end 

%plot
figure(1)
plot(m,error)
xlabel('迭代次数')
ylabel('均方误差')
title('BP算法的学习曲线')
figure(2)
plot(x,y)
hold on
plot(x,t,'r')
legend('目标曲线','逼近曲线')