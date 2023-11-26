function [y] = func(x,w,wk)
%输入数据，返回预测结果
p=6;
x=[x -1];
neto=0;
for j=1:p 
  neti(j)=w(j,1)*x(1)+w(j,2)*x(2);
  a(j)=1/(1+exp(-neti(j)));
  %隐层的激活函数采取sigmoid函数，f(x)=1/(1+exp(-x))
  neto=neto+wk(j)*a(j);
end
neto=neto+wk(p+1)*(-1);
y=neto;

