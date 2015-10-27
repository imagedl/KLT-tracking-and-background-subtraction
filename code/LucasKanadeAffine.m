function M = LucasKanadeAffine(It,It1)

%Initialize Stuff
It=im2double(It);
It1=im2double(It1);
H=zeros(6,6);
p=zeros(6,1);
dp=[1;1;1;1;1;1];
M=[1 + p(1), p(3), p(5);
   p(2), 1+p(4), p(6);
   0    ,  0,      1];

[x,y]=meshgrid(1:size(It,2), 1:size(It,1));
%Pre-computation Steps

[Ix,Iy] = imgradientxy(It); %------------>Try Diffferent gradient 'methods'
s1 = Ix.*x; % first element of gradientT*JacobW for all pixels
s2 = Iy.*x;% second element of gradientT*JacobW for all pixels
s3 = Ix.*y;
s4 = Iy.*y;
s5 = Ix;
s6 = Iy;
 
    %-->Calculating the Hessian Matriix
    %-->For Each pixel Hessian will be of form (steepest1(pixel)^2 steepest1(pixel)*steepest2(pixel);
    %                                            steepest1(pixel)*steepest2(pixel)
    %                                            steepest2(pixel)^2]
    %For overall Hessian we'll have summations everywhere
H(1,1) = sum(sum((s1.^2),1),2);H(1,2) = sum(sum((s1.*s2),1),2);
H(1,3) = sum(sum((s1.*s3),1),2);H(1,4) = sum(sum((s1.*s4),1),2);
H(1,5) = sum(sum((s1.*s5),1),2);H(1,6) = sum(sum((s1.*s6),1),2);
H(2,2) = sum(sum((s2.^2),1),2);H(2,3) = sum(sum((s2.*s3),1),2);
H(2,4) = sum(sum((s2.*s4),1),2);H(2,5) = sum(sum((s2.*s5),1),2);
H(2,6) = sum(sum((s2.*s6),1),2);H(3,3) = sum(sum((s3.^2),1),2);
H(3,4) = sum(sum((s3.*s4),1),2);H(3,5) = sum(sum((s3.*s5),1),2);
H(3,6) = sum(sum((s3.*s6),1),2);H(4,4) = sum(sum((s4.^2),1),2);
H(4,5) = sum(sum((s4.*s5),1),2);H(4,6) = sum(sum((s4.*s6),1),2);
H(5,5) = sum(sum((s5.^2),1),2);H(5,6) = sum(sum((s5.*s6),1),2);
H(6,6) = sum(sum((s6.^2),1),2);
H(2,1) = H(1,2); H(3,1)=H(1,3); H(3,2)=H(2,3);H(4,1)=H(1,4);
H(4,2)=H(2,4); H(4,3)=H(3,4); H(5,1)=H(1,5); H(5,2)=H(2,5); H(5,3)=H(3,5); 
H(5,4)=H(4,5); H(6,1)=H(1,6); H(6,2)=H(2,6);H(6,3)=H(3,6);H(6,4)=H(4,6); H(6,5)=H(5,6);
invH = inv(H);
th=0.01;
%Iteration Steps
while norm(dp)>th

It1W=interp2(It1, M(1,1)*x + M(1,2)*y + M(1,3), M(2,1)*x + M(2,2)*y + M(2,3), 'cubic');
err_image = It1W - It;
err_image(isnan(err_image))=0;
sdpu1 = s1.*err_image; % First component of steepest descent parameter update
sdpu2 = s2.*err_image; % Second component of steepest descent parameter update
sdpu3 = s3.*err_image;
sdpu4 = s4.*err_image;
sdpu5 = s5.*err_image;
sdpu6 = s6.*err_image;
sigspdu1 = sum(sum(sdpu1,1),2);
sigsdpu2 = sum(sum(sdpu2,1),2);
sigsdpu3 = sum(sum(sdpu3,1),2);
sigsdpu4 = sum(sum(sdpu4,1),2);
sigsdpu5 = sum(sum(sdpu5,1),2);
sigsdpu6 = sum(sum(sdpu6,1),2);
dp = invH*[sigspdu1;sigsdpu2;sigsdpu3;sigsdpu4;sigsdpu5;sigsdpu6];

inv_dp = (1/(((1+dp(1,1))*(1+dp(4,1)))-(dp(2,1)*dp(3,1)))) * [-dp(1,1)-dp(1,1)*dp(4,1)+dp(2,1)*dp(3,1); 
                                                                        -dp(2,1);
                                                                       -dp(3,1);
                                                        -dp(4,1)-dp(1,1)*dp(4,1)+dp(2,1)*dp(3,1);
                                                        -dp(5,1)-dp(5,1)*dp(4,1)+dp(6,1)*dp(3,1);
                                                        -dp(6,1)-dp(1,1)*dp(6,1)+dp(2,1)*dp(5,1)];
                                                     
       

p= p + inv_dp + [p(1)*inv_dp(1) + p(3)*inv_dp(2);
                 p(2)*inv_dp(1) + p(4)*inv_dp(2);
                 p(1)*inv_dp(3) + p(3)*inv_dp(4);
                 p(2)*inv_dp(3) + p(4)*inv_dp(4);
                 p(1)*inv_dp(5) + p(3)*inv_dp(6);
                 p(2)*inv_dp(5) + p(4)*inv_dp(6)];
M=[1 + p(1), p(3), p(5);
   p(2), 1+p(4), p(6);
   0    ,  0,      1];

end



end








