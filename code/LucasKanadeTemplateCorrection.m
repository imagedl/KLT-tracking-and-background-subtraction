function [u,v] = LucasKanadeTemplateCorrection(It, It1, rect)
It=im2double(It);
It1=im2double(It1);
H=zeros(2,2);
p=zeros(2,1);
dp=[1;1];
rectbase=[60,117,146,152];
T=It(rectbase(2):rectbase(4), rectbase(1): rectbase(3));
Itrect=It1(rect(2):rect(4), rect(1):rect(3));
[x,y]=meshgrid(1:size(T,2), 1:size(T,1));
%Pre-computation Steps
JacobianW=[1,0;0,1];
[gradTx,gradTy] = imgradientxy(T); %------------>Try Diffferent gradient 'methods'
steepest1 = gradTx*JacobianW(1,1) + gradTy*JacobianW(2,1); % first element of gradientT*JacobW for all pixels

 steepest2 = JacobianW(1,2)*gradTx + JacobianW(2,2)*gradTy;% second element of gradientT*JacobW for all pixels
    %-->Calculating the Hessian Matriix
    %-->For Each pixel Hessian will be of form (steepest1(pixel)^2 steepest1(pixel)*steepest2(pixel);
    %                                            steepest1(pixel)*steepest2(pixel)
    %                                            steepest2(pixel)^2]
    %For overall Hessian we'll have summations everywhere
H(1,1) = sum(sum((steepest1.^2),1),2);
H(1,2) = sum(sum((steepest1.*steepest2),1),2);
H(2,1) = H(1,2);
H(2,2) = sum(sum((steepest2.^2),1),2);
invH = inv(H);
th=0.01;
%Iteration Steps
while norm(dp)>th
utemp=p(1)*ones(size(x,1), size(x,2));
vtemp=p(2)*ones(size(y,1),size(y,2));

It1W=interp2(Itrect, x+utemp, y+vtemp, 'cubic');
% figure(3)
% imshow(It1W)
% It1W = It1(rect(2)+floor(p(2)) : rect(4)+floor(p(2)), rect(1) +floor(p(1)) : rect(3) +floor(p(1)));
err_image = It1W - T;
err_image(isnan(err_image))=0;
sdpu1 = steepest1.*err_image; % First component of steepes descent parameter update
sdpu2 = steepest2.*err_image; % Second component of steepes descent parameter update
sigspdu1 = sum(sum(sdpu1,1),2);
sigsdpu2 = sum(sum(sdpu2,1),2);
dp = invH*[sigspdu1;sigsdpu2];
p=p-dp;
end

u=p(1);
v=p(2);

end