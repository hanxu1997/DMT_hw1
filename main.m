clc;
clear;
img  = imread('input.jpg');
img_gray = rgb2gray(img);
figure(1);
imshow(img_gray);
% sobel edge
BW = edge(img_gray,'sobel');
imshow(BW);
title('image edge');
imwrite(BW,'edge.jpg');

% the theta and rho of transformed space
[H,Theta,Rho] = hough(BW);
% label the top 5 intersections
P  = houghpeaks(H,7,'threshold',0.5*max(H(:)));
x = Theta(P(:,2)); 
y = Rho(P(:,1));


% find lines and plot them
lines = houghlines(BW,Theta,Rho,P,'FillGap',200,'MinLength',120);
figure, imshow(img),hold on
max_len = 0;
for k = 1:length(lines)
 xy = [lines(k).point1; lines(k).point2];
 plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','r');
end