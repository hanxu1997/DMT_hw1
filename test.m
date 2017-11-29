clear;clc;
I=imread('input.jpg');
img_gray = rgb2gray(I);
I2=im2bw(I);%¶þÖµ»¯
BW = edge(img_gray,'sobel');
figure(3);
subplot(1,2,1);
imshow(I2);
index = find(I2==0);
BW(index) = 0;
subplot(1,2,2);
imshow(BW);
