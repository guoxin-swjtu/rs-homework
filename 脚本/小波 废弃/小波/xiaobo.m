imgPan = imread('d:\DCT\aa.bmp');
imgMul = imread('d:\DCT\bb.bmp');
%imgMul=rgb2gray(imgMul);
subplot(1,3,1), imshow(imgPan), xlabel ('(a)�߷ֱ���ȫɫͼ��' );
subplot(1,3,2), imshow(imgMul), xlabel ('(b)�����ͼ��' );

imgPan=rgb2gray(imgPan);
%����f2ͼ��R��G��B ����
mulR = imgMul (:,:,1);
mulG = imgMul (:,:,2);
mulB = imgMul (:,:,3);

% ��f1 ȫɫͼ�����db13 С������ֽ�
[Cpan,Lpan] = wavedec2(imgPan,3,'db13' );
imgWH = Lpan(1,:);
length = imgWH(1)*imgWH(2);
% ��f2ͼ���������ֱ����db13 С������ֽ�
[Ctmr,Ltmr] = wavedec2(mulR,3,'db13' );
Cr = Cpan; Cr(1:length) = Ctmr(1:length);
[Ctmg,Ltmg] = wavedec2(mulG,3,'db13' );
Cg = Cpan; Cg(1:length) = Ctmg(1:length);
[Ctmb,Ltmb] = wavedec2(mulB,3,'db13' );
Cb = Cpan; Cb(1:length) = Ctmb(1:length);
% ��f2ͼ�����������db13 С����任�ع�
imgResult(:,:,1) = waverec2(Cr,Lpan,'db13' );
imgResult(:,:,2) = waverec2(Cg,Lpan,'db13' );
imgResult(:,:,3) = waverec2(Cb,Lpan,'db13' );
%д�벢��ʾ�ںϺ�ͼ���ļ�
imwrite(uint8(imgResult), 'd:\DCT\Merge.bmp' );
subplot(1,3,3), imshow(uint8(imgResult)), xlabel ('(c)С���ں�ͼ��' );
