
%Load File
carseq = load('../data/sylvseq.mat');
rect(1,1:4)=[102,62,156,108];

figure(2)
hold on
for i=1:size(carseq.frames,3)-1
% rect=rectangle('position', [rect(1), rect(2), rect(3)-rect(1), rect(4)-rect(2)]);

% rectangle('position', [rect(1), rect(2), rect(3)-rect(1), rect(4)-rect(2)], 'EdgeColor', 'g');
It=carseq.frames(:,:,i);

im = insertShape(It,'rectangle', [rect(i,1),rect(i,2), rect(i,3)-rect(i,1),rect(i,4)-rect(i,2)]);
imshow(im);
It1=carseq.frames(:,:,i+1);
[u,v] = LucasKanade(It, It1, rect(i,1:4));
rect(i+1,1:4)=  rect(i,1:4) +round([u,v,u,v]);
 
end
hold off
