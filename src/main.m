clc;
clear;
img  = imread('..\input\input.jpg');

% 1. 将图像转成灰度图
img_gray = rgb2gray(img);
figure(1);
subplot(1,2,1);
imshow(img_gray);
title('灰度图');
% 2. 边缘检测
BW = edge(img_gray,'sobel');
subplot(1,2,2);
imshow(BW);
title('边缘检测');
imwrite(BW,'..\output\edge.jpg');

% 3. 霍夫变换得到A4纸边缘
[H,Theta,Rho] = hough(BW);
P  = houghpeaks(H,7,'threshold',0.4*max(H(:)));
x = Theta(P(:,2)); 
y = Rho(P(:,1));
lines = houghlines(BW,Theta,Rho,P,'FillGap',200,'MinLength',180);
figure(2);
subplot(1,2,1);
imshow(img);
title('由边缘找出四个角点');
hold on
for k = 1:length(lines)
 xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','r');
 hold on
end


% 4. 通过A4纸的边计算A4纸的四个角点
line_14 = [ lines(1).point1;lines(1).point2;lines(4).point1;lines(4).point2];
A = intersection(line_14);
line_13 = [ lines(1).point1;lines(1).point2;lines(3).point1;lines(3).point2];
B = intersection(line_13);
line_32 = [ lines(3).point1;lines(3).point2;lines(2).point1;lines(2).point2];
C = intersection(line_32);
line_24 = [ lines(2).point1;lines(2).point2;lines(4).point1;lines(4).point2];
D = intersection(line_24);
A = round(A);
B = round(B);
C = round(C);
D = round(D);
plot(A(1),A(2),'.','markersize',20,'color','b');
plot(B(1),B(2),'.','markersize',20,'color','b');
plot(C(1),C(2),'.','markersize',20,'color','b');
plot(D(1),D(2),'.','markersize',20,'color','b');

% 透视变换后图像
original = [A;B;C;D];
new = [1 1;1 960;540 960;540 1];
TForm = cp2tform(original,new,'projective');
figure(2);
subplot(1,2,2);
output_img = imtransform(img,TForm,'XData',[1 540], 'YData',[1 960]);
imshow(output_img);
title('透视变换后图像');
imwrite(output_img,'..\output\output.jpg');





