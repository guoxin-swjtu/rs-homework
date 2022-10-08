clc;
clear;
close all;
% ����ͼ��
imgPan = imread('pan-caijian.tif','tif'); 
imgMul = imread('mss-caijian.tif','tif');

%ͼƬ��С���� ����matalb��ֵ�ֻ��ķ�������ת����ͬ�ȴ�С
[imgPanN, imgPanM]=size(imgPan);
imgMul = imresize(imgMul,[imgPanN imgPanM]);

%��ң��ͼ���һ��ֵ�� matlab �޷���ȡ�Ǹ���ʽ ����matlab��int15��ʾ
imgPan=mat2gray(imgPan);
imgPan=im2uint8(imgPan);

imgMul=mat2gray(imgMul);
imgMul=im2uint8(imgMul);

%����ͼ�� R�� G�� B�����������
mulR = imgMul (:,:,3); 
mulG = imgMul (:,:,2); 
mulB = imgMul (:,:,1); 
mulH = imgMul (:,:,4); 

% �߷ֱ���ȫɫͼС���任
[Cpan,Lpan] = wavedec2(imgPan,15,'dmey');
imgWH = Lpan(1,:);
length = imgWH(1)*imgWH(2);

[Ctmr,Ltmr] = wavedec2(mulR,15,' dmey' ); 
% Rͨ��С���任���õ��ĵ�Ƶ�滻ȫɫͼ�ĵ�Ƶϵ��
Cr = Cpan; Cr(1:length) = Ctmr(1:length);

[Ctmg,Ltmg] = wavedec2(mulG,15,' dmey' );
Cg = Cpan; Cg(1:length) = Ctmg(1:length);

[Ctmb,Ltmb] = wavedec2(mulB,15,' dmey' );
Cb = Cpan; Cb(1:length) = Ctmb(1:length);

[Ctmh,Ltmh] = wavedec2(mulH,15,' dmey' ); 
Ch = Cpan; Ch(1:length) = Ctmh(1:length); 


% ��ƵΪ�����ͼ�ĵ�Ƶϵ������ƵΪȫɫͼ�ĸ�Ƶϵ��������С���ع�
imgResult(:,:,3) = waverec2(Cr,Lpan,' dmey' ); 
imgResult(:,:,2) = waverec2(Cg,Lpan,' dmey' ); 
imgResult(:,:,1) = waverec2(Cb,Lpan,' dmey' ); 
imgResult(:,:,4) = waverec2(Ch,Lpan,' dmey' ); 

imgResult=uint8(round(imgResult));
%д�벢��ʾ�ںϺ�ͼ���ļ� 
% imResult2(:,:,1)=imgResult(:,:,1);
% imResult2(:,:,2)=imgResult(:,:,2);
% imResult2(:,:,3)=imgResult(:,:,3);

imwrite(imgResult2, 'Mergedmey_15.tif' ); 
%matlabֻ����ʾ��ά����ͼ�����ѡ�������������ν��������ʾ
figure
imshow(imgResult(:,:,1:3)), xlabel ('Mergedmey_15' );