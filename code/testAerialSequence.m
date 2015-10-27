close all
aerialseq = load('../data/aerialseq.mat');
figure(2)
for i=1:size(aerialseq.frames,3)-1

 mask(:,:,i) = SubtractDominantMotion(aerialseq.frames(:,:,i), aerialseq.frames(:,:,i+1));
 imshow(imfuse(mask(:,:,i),aerialseq.frames(:,:,i)));

% if(i==30 || i==60|| i==90 || i==120)
% 
% imname=strcat('../results/aerialseq_frame', 'i', '.jpg');
% imwrite(imfuse(mask(:,:,i),aerialseq.frames(:,:,i)), imname, 'jpg');
% end 
end


% save('../results/mask.mat', 'mask');