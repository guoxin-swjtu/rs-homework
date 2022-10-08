%%%% 计算图像的平均梯度%% %%%%%%

%读入图像
img=imread('***.tif');

%精度转换
img = double(img);

%获取图像大小信息
    [r,c,b] = size(img);
    dx = 1;
    dy = 1;
    for k = 1 : b
        band = img(:,:,k);
        dzdx=0.0;
        dzdy=0.0;
        [dzdx,dzdy] = gradient(band,dx,dy);
        s = sqrt((dzdx .^ 2 + dzdy .^2) ./ 2);
        g(k) = sum(sum(s)) / ((r - 1) * (c - 1));
    end
%求图像的平均梯度
MeanGradient= mean(g);