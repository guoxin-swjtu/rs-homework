function seg = imseg(img,Lseg,F)
if F
    figure; imshow(img); axis on; title('Original Image')
    figure;
end
L = size(img);
max_row = floor(L(1)/Lseg);
max_col = floor(L(2)/Lseg);
seg = cell(max_row,max_col);

r1 = 1;
for row = 1:max_row
c1=1;
for col = 1:max_col
r2 = r1+Lseg-1;
c2 = c1+Lseg-1;
seg(row,col) = {img(r1:r2,c1:c2,:)};
if F
subplot(max_row,max_col,(row-1)*max_col+col)
imshow(cell2mat(seg(row,col)))        
end
c1=c2+1;
end
r1 = r2 +1;
end