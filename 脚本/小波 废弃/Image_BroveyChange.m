function Image3 = Image_BroveyChange(Image1,Image2)%函数名称为Image_BroveyChange,输入参数Image1,Image2,输出参数Image3
%Image1表示多光谱图像
[lines1,samples1,bands1] = size(Image1);
%Image2表示全色影像
[lines2,samples2,bands2] = size(Image2);
%Image3表示Brovey变换融合后的图像
Image3 = zeros(lines2,samples2,bands1);%初始化矩阵
for k = 1:bands1
    for i = 1:lines2
        for j = 1:samples2
            Image3(i,j,k) = Image2(i,j,k)*Image1(i,j,k)/sum(Image1(i,j,:));%其中Image1/sum为归一化过程
        end
    end
end
figure(1)
subplot(1,3,1);
imshow(uint8(Image1));
title('多光谱影像');
subplot(1,3,2);
imshow(uint8(Image2));
title('全色影像');
subplot(1,3,3);
imshow(uint8(Image3));
title('Brovey变换融合后的影像');
end