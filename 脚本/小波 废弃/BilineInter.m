function M=BilineInter(datar,p,q)
%datar为低分辨率，[p,q]为要变换的大小

[m,n,k]=size(datar);
A=zeros(m+2,n+2,k);
M=zeros(p,q,k);

for t=1:k
A(2:m+1,2:n+1,t)=datar(:,:,t);
end
for i=1:p
    for j=1:q
        I=ceil(i*m/p);
        J=ceil(j*n/q);
        u=I-i*m/p;
        v=J-j*n/q;
        a=[A(I,J,:),A(I,J+1,:);A(I+1,J,:),A(I+1,J+1,:)];
        w=[(1-u)*(1-v),(1-u)*v;(1-v)*u,u*v];
        M(i,j,:)=sum(sum(a.*w));
    end
end 

end
