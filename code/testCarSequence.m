close all
%Load File
carseq = load('../data/carseq.mat');
 rects(1,1:4)=[60,117,146,152];

%  rects(1,1:4)= [122, 59, 169, 104];

figure(2)
hold on
for i=1:size(carseq.frames,3)-1
% rect=rectangle('position', [rect(1), rect(2), rect(3)-rect(1), rect(4)-rect(2)]);

% rectangle('position', [rect(1), rect(2), rect(3)-rect(1), rect(4)-rect(2)], 'EdgeColor', 'g');
It=carseq.frames(:,:,i);

im = insertShape(It,'rectangle', [rects(i,1),rects(i,2), rects(i,3)-rects(i,1),rects(i,4)-rects(i,2)], 'Color', 'green', 'LineWidth', 3);
imshow(im);
if(i==1 || i==4|| i==100|| i==125|| i==200 || i==300 || i==380||i==400)
imnum= i;
imname=strcat('../results/carseqframe', char(i), '.jpg');
imwrite(im, imname, 'jpg');
end
It1=carseq.frames(:,:,i+1);
[u,v] = LucasKanade(It, It1, rects(i,1:4));
rects(i+1,1:4)=  rects(i,1:4) +round([u,v,u,v]);
 
end
save('../results/carseqrects.mat', 'rects'); 
hold off
