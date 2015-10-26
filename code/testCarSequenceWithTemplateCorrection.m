close all
%Load File
carseq = load('../data/carseq.mat');
 rects(1,1:4)=[60,117,146,152];
 rects2(1,1:4)=[60,117,146,152];

Itbase=carseq.frames(:,:,1);
ustar=0;
vstar=0;
figure(2)
hold on
for i=1:size(carseq.frames,3)-1

It=carseq.frames(:,:,i);

im = insertShape(It,'rectangle', [rects(i,1),rects(i,2), rects(i,3)-rects(i,1),rects(i,4)-rects(i,2)],'Color', 'green', 'LineWidth', 3);
im = insertShape(im,'rectangle', [rects2(i,1),rects2(i,2), rects2(i,3)-rects2(i,1),rects2(i,4)-rects2(i,2)], 'Color', 'yellow', 'LineWidth', 3);
imshow(im);
if(i==1 || i==4|| i==100|| i==125|| i==200 || i==300 || i==380|| i==400)
imnum= i;
imname=strcat('../results/carseqtemplatecorrectionframe', i, '.jpg');
imwrite(im, imname, 'jpg');
end
It1=carseq.frames(:,:,i+1);
[u,v] = LucasKanade(It, It1, rects(i,1:4));
[ustar,vstar]=LucasKanadeTemplateCorrection(Itbase, It1, rects2(i,1:4));
rects(i+1,1:4)=rects(i,1:4) +round([u,v,u,v]);
rects2(i+1,1:4)=  rects2(i,1:4) + round([ustar,vstar,ustar,vstar]);

end

save('../results/carseqrects-wcrt.mat', 'rects2'); 
hold off
