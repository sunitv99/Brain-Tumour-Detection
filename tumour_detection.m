I=imread('4.jpg');
figure, imshow(I); title('Brain MRI Image');
I = imresize(I,[200,200]);
I= rgb2gray(I);
I= im2bw(I,.6);
figure, imshow(I);title('Thresholded Image');
hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
L = watershed(gradmag);
Lrgb = label2rgb(L);
figure, imshow(Lrgb), title('Watershed segmented image ')
se = strel('disk', 20);
Ie = imerode(I, se);
figure,imshow(Ie)
Iobr = imreconstruct(Ie, I);
figure,imshow(Iobr)
Iobrd = imdilate(Iobr, se);
figure,imshow(Iobrd)
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
figure,imshow(Iobrcbr)
Iobrcbr = imcomplement(Iobrcbr);
figure,imshow(Iobrcbr)
I3 = I;
bw = im2bw(Iobrcbr);
figure
imshow(bw), title('only tumor')
