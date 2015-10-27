function mask = SubtractDominantMotion(image1, image2)

image1=im2double(image1);
image2=im2double(image2);
[M] = LucasKanadeAffine(image1,image2);

[x,y] = meshgrid(1:size(image1,2), 1:size(image1,1));

image2W = interp2(image2, M(1,1)*x + M(1,2)*y + M(1,3), M(2,1)*x + M(2,2)*y + M(2,3), 'cubic');

A = image2W - image1;
A(isnan(A))=0;
dilatemask = ones(3); dilatemask(5) = 0; % 3x3 mask

mask = imdilate(A,dilatemask);


















end