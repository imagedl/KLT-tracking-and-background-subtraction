close all
%Load File
sylvseq = load('../data/sylvextseq.mat');
basesFile = load('../data/sylvextbases.mat');
bases=basesFile.bases;

rects(1,1:4)= [122, 59, 169, 104];
rects2(1,1:4)= [122, 59, 169, 104];


figure(2)

hold on
for i=1:size(sylvseq.frames,3)-1

It=sylvseq.frames(:,:,i);

im = insertShape(It,'rectangle', [rects(i,1),rects(i,2), rects(i,3)-rects(i,1),rects(i,4)-rects(i,2)], 'Color', 'yellow', 'LineWidth', 3);
im = insertShape(im,'rectangle', [rects2(i,1),rects2(i,2), rects2(i,3)-rects2(i,1),rects2(i,4)-rects2(i,2)], 'Color', 'green', 'LineWidth', 3);
imshow(im);
% if(i==1||i==100||i==200||i==300||i==350|| i==350)
% 
% 
% imname=strcat('../results/sylvseqs_frame', '.jpg');
% imwrite(im, imname, 'jpg');
% pause();
% end
It1=sylvseq.frames(:,:,i+1);
[u,v] = LucasKanadeBasis(It, It1, rects(i,1:4), bases);
rects(i+1,1:4)=  rects(i,1:4) +round([u,v,u,v]);
[ustar,vstar]=LucasKanade(It,It1, rects2(i,1:4));
rects2(i+1,1:4)= rects2(i,1:4) +round([ustar,vstar,ustar,vstar]);

end
% save('../results/sylvseqrects.mat', 'rects'); 
hold off
