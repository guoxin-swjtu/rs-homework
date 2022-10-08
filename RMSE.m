h1=imread('pan-caijian.tif');
h2=imread('***.tif');
%      ����ͼ��ľ��������
%      ��׼ͼ��   h1
%      �ںϺ�ͼ�� h2
%      f=RMSE(h1��h2);
%�ں�ͼ�����׼ͼ�����̶ȣ�����ԽС˵���ں�ͼ�����׼ͼ��Խ�ӽ�
s=size(size(h1));%�ж��ǻҶ�ͼ����RGB
if s(2)==2
    f1=h1;
    f2=h2;
else
    f1=rgb2gray(h1);
    f2=rgb2gray(h2);
end  
G1=double(f1);
G2=double(f2);
[m1,n1]=size(G1);
[m2,n2]=size(G2);
m=min(m1,m2);
n=min(n1,n2);
c=0;
for i=1:m
    for j=1:n
        w=G1(i,j)-G2(i,j);
        c=c+w^2;
    end
end
f=sqrt(c/(m*n));