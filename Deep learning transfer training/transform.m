clear all;
clc;
%%本文件可以实现批量改变图片大小、图片颜色3通道化，这两个功能
%用于迁移学习图像与处理
%图像预处理
%readdir为需要处理的图像所在的文件夹路径，只能含有图片，图片格式无所谓
readdir="../imgdata/tablet_computer";%其他文件夹分别为 air_conditioner power_strip stapler

% 写入图像的格式
writetype = 'jpg';
% 写入图像的目录
writedir = ["./tablet_computer_transformed"];
% 大小改变因子
resizefactor = [227 227];

% 创建改大小之后图像目录，如果目录已经存在会报警告，但是不影响使用
mkdir(writedir);
% 读取目录内所有所有图像目录信息
imnames = dir(readdir);
% 去掉目录信息中的无用项( .和 .. )
imnames(1:2)=[];
% 统计图像个数
imcnt=length(imnames);

% 针对每一个图像
for imidx = 1:1:imcnt
    % 读入图像
    imtemp = imread(fullfile(readdir,imnames(imidx).name));
%调整图像RGB通道数量，若不为3，则改为3
if numel(size(imtemp)) ~= 3
   imtemp = cat(3,imtemp,imtemp,imtemp);% 用于将图片改为3通道
end
    % 改变图像大小
    imtemp = imresize(imtemp,resizefactor);
    % 按照需要格式写入图像
    imwrite(imtemp,fullfile(writedir,[imnames(imidx).name(1:end-3),writetype]));
end