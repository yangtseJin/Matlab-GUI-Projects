clear all;
clc;
%%���ļ�����ʵ�������ı�ͼƬ��С��ͼƬ��ɫ3ͨ����������������
%����Ǩ��ѧϰͼ���봦��
%ͼ��Ԥ����
%readdirΪ��Ҫ�����ͼ�����ڵ��ļ���·����ֻ�ܺ���ͼƬ��ͼƬ��ʽ����ν
readdir="../imgdata/tablet_computer";%�����ļ��зֱ�Ϊ air_conditioner power_strip stapler

% д��ͼ��ĸ�ʽ
writetype = 'jpg';
% д��ͼ���Ŀ¼
writedir = ["./tablet_computer_transformed"];
% ��С�ı�����
resizefactor = [227 227];

% �����Ĵ�С֮��ͼ��Ŀ¼�����Ŀ¼�Ѿ����ڻᱨ���棬���ǲ�Ӱ��ʹ��
mkdir(writedir);
% ��ȡĿ¼����������ͼ��Ŀ¼��Ϣ
imnames = dir(readdir);
% ȥ��Ŀ¼��Ϣ�е�������( .�� .. )
imnames(1:2)=[];
% ͳ��ͼ�����
imcnt=length(imnames);

% ���ÿһ��ͼ��
for imidx = 1:1:imcnt
    % ����ͼ��
    imtemp = imread(fullfile(readdir,imnames(imidx).name));
%����ͼ��RGBͨ������������Ϊ3�����Ϊ3
if numel(size(imtemp)) ~= 3
   imtemp = cat(3,imtemp,imtemp,imtemp);% ���ڽ�ͼƬ��Ϊ3ͨ��
end
    % �ı�ͼ���С
    imtemp = imresize(imtemp,resizefactor);
    % ������Ҫ��ʽд��ͼ��
    imwrite(imtemp,fullfile(writedir,[imnames(imidx).name(1:end-3),writetype]));
end