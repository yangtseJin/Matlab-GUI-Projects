I = imread('./测试图片/stapler2_demo.jpg');
figure
imshow(I)
net=alexnet
sz = net.Layers(1).InputSize
I = imresize(I,sz(1:2));
label = classify(net,I)
figure
imshow(I)
title(label)