
%Load File
carseq = load('../data/carseq.mat');
rect(1,1:4)=[60,117,146,152];
figure(2)
hold on
for i=1:size(carseq.frames,3)-1
% rect=rectangle('position', [rect(1), rect(2), rect(3)-rect(1), rect(4)-rect(2)]);

% rectangle('position', [rect(1), rect(2), rect(3)-rect(1), rect(4)-rect(2)], 'EdgeColor', 'g');
It=carseq.frames(:,:,i);
It1=carseq.frames(:,:,i+1);
[u,v] = LucasKanade(It, It1, rect(i,1:4));
rect(i+1,1:4)=rect(i,1:4) +[floor(u),floor(v),floor(u),floor(v)];
%  imshow(It);
end
hold off
