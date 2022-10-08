clc;
clear;
close all;
% 读入图像
imgPan = imread('pan-caijian.tif','tif'); 
imgMul = imread('mss-caijian.tif','tif');

%图片大小不等 进行matalb插值抑或别的方法进行转换成同等大小
[imgPanN, imgPanM]=size(imgPan);
imgMul = imresize(imgMul,[imgPanN imgPanM]);

%将遥感图像归一二值化 matlab 无法读取那个格式 并用matlab的int15表示
imgPan=mat2gray(imgPan);
imgPan=im2uint8(imgPan);

imgMul=mat2gray(imgMul);
imgMul=im2uint8(imgMul);

%分离图像 R、 G、 B、近红外分量
mulR = imgMul (:,:,3); 
mulG = imgMul (:,:,2); 
mulB = imgMul (:,:,1); 
mulH = imgMul (:,:,4); 

% 高分辨率全色图小波变换
[Cpan,Lpan] = wavedec2(imgPan,15,'dmey');
imgWH = Lpan(1,:);
length = imgWH(1)*imgWH(2);

[Ctmr,Ltmr] = wavedec2(mulR,15,' dmey' ); 
% R通道小波变换，得到的低频替换全色图的低频系数
Cr = Cpan; Cr(1:length) = Ctmr(1:length);

[Ctmg,Ltmg] = wavedec2(mulG,15,' dmey' );
Cg = Cpan; Cg(1:length) = Ctmg(1:length);

[Ctmb,Ltmb] = wavedec2(mulB,15,' dmey' );
Cb = Cpan; Cb(1:length) = Ctmb(1:length);

[Ctmh,Ltmh] = wavedec2(mulH,15,' dmey' ); 
Ch = Cpan; Ch(1:length) = Ctmh(1:length); 


% 低频为多光谱图的低频系数，高频为全色图的高频系数，进行小波重构
imgResult(:,:,3) = waverec2(Cr,Lpan,' dmey' ); 
imgResult(:,:,2) = waverec2(Cg,Lpan,' dmey' ); 
imgResult(:,:,1) = waverec2(Cb,Lpan,' dmey' ); 
imgResult(:,:,4) = waverec2(Ch,Lpan,' dmey' ); 

imgResult=uint8(round(imgResult));
%写入并显示融合后图像文件 
% imResult2(:,:,1)=imgResult(:,:,1);
% imResult2(:,:,2)=imgResult(:,:,2);
% imResult2(:,:,3)=imgResult(:,:,3);

imwrite(imgResult2, 'Mergedmey_15.tif' ); 
%matlab只能显示三维以内图像，因此选择其中三个波段进行组合显示
figure
imshow(imgResult(:,:,1:3)), xlabel ('Mergedmey_15' );