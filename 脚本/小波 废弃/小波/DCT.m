
imgPan = imread('D:\桌面\遥感信息模型与智能理解\第二次报告\数据\GF2_PMS2_E103.4_N29.5_20150717_L1A0000931673-PAN2.tiff');
imgMul = imread('D:\桌面\遥感信息模型与智能理解\第二次报告\数据\GF2_PMS2_E103.4_N29.5_20150717_L1A0000931673-MSS2.tiff');
%imgMul=rgb2gray(imgMul);
subplot(1,3,1), imshow(imgPan), xlabel ('(a)全色光学图像' );
subplot(1,3,2), imshow(imgMul), xlabel ('(b)多光谱图像' );

imgPan=rgb2gray(imgPan);
%分离f2图像R、G、B 分量
mulR = imgMul (:,:,1);
mulG = imgMul (:,:,2);
mulB = imgMul (:,:,3);

I=(mulR+mulG+mulB)/sqrt(3);
I1=I;
I1=I1*0;

V1=(mulR+mulG-2*mulB)/sqrt(6);
V2=(mulR-mulG)/sqrt(2);
V2=double(V2);
V1=double(V1);

P=imgseg(imgPan,64,0);
I=imgseg(I,64,0);
I1=imgseg(I1,64,0);
for i=1:4
    for j=1:4
      DP=dct2(P{i,j});
      DI=dct2(I{i,j});
      DP(33:64,:)=0;DP(:,33:64)=0;
      DI(1:32,1:32)=0;
      DPI=DP+DI;
      I1{i,j}=idct2(DPI);
    end
end
%imshow(cell2mat(I1),[0,255]);
imgResult(:,:,1)=1/sqrt(3)*cell2mat(I1) +1/sqrt(6)*V1 +1/sqrt(2)*V2;
imgResult(:,:,2)=1/sqrt(3)*cell2mat(I1) +1/sqrt(6)*V1 -1/sqrt(2)*V2;
imgResult(:,:,3)=1/sqrt(3)*cell2mat(I1) -2/sqrt(6)*V1;

imwrite(uint8(imgResult), 'd:\Merge.bmp' );
subplot(1,3,3), imshow(uint8(imgResult)), xlabel ('(c)DCT融合图像' );