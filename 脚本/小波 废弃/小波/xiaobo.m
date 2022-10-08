imgPan = imread('d:\DCT\aa.bmp');
imgMul = imread('d:\DCT\bb.bmp');
%imgMul=rgb2gray(imgMul);
subplot(1,3,1), imshow(imgPan), xlabel ('(a)高分辨率全色图像' );
subplot(1,3,2), imshow(imgMul), xlabel ('(b)多光谱图像' );

imgPan=rgb2gray(imgPan);
%分离f2图像R、G、B 分量
mulR = imgMul (:,:,1);
mulG = imgMul (:,:,2);
mulB = imgMul (:,:,3);

% 对f1 全色图像进行db13 小波三层分解
[Cpan,Lpan] = wavedec2(imgPan,3,'db13' );
imgWH = Lpan(1,:);
length = imgWH(1)*imgWH(2);
% 对f2图像三分量分别进行db13 小波三层分解
[Ctmr,Ltmr] = wavedec2(mulR,3,'db13' );
Cr = Cpan; Cr(1:length) = Ctmr(1:length);
[Ctmg,Ltmg] = wavedec2(mulG,3,'db13' );
Cg = Cpan; Cg(1:length) = Ctmg(1:length);
[Ctmb,Ltmb] = wavedec2(mulB,3,'db13' );
Cb = Cpan; Cb(1:length) = Ctmb(1:length);
% 对f2图像各分量进行db13 小波逆变换重构
imgResult(:,:,1) = waverec2(Cr,Lpan,'db13' );
imgResult(:,:,2) = waverec2(Cg,Lpan,'db13' );
imgResult(:,:,3) = waverec2(Cb,Lpan,'db13' );
%写入并显示融合后图像文件
imwrite(uint8(imgResult), 'd:\DCT\Merge.bmp' );
subplot(1,3,3), imshow(uint8(imgResult)), xlabel ('(c)小波融合图像' );
