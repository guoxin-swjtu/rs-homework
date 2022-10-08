%%%% ����ͼ���ƽ���ݶ�%% %%%%%%

%����ͼ��
img=imread('***.tif');

%����ת��
img = double(img);

%��ȡͼ���С��Ϣ
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
%��ͼ���ƽ���ݶ�
MeanGradient= mean(g);