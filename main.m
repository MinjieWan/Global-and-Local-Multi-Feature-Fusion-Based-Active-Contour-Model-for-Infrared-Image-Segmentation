clear all;
clc;
close all;

%% parameter setting
iter = 60;
alpha = 400;
epsilon = 1.0; 
lambda = 0.5;
beta = 1.0;
Gb = fspecial('gaussian',5,beta); 
r =3.0;
Gr = fspecial('gaussian', 5, r);
n = 1;

%% load IR image
filename = 'E:/PhdStudy/2021主动轮廓分割论文/Matlab仿真/专利算法撰写资料/专利算法撰写资料/input/R2_input/man1.bmp';
% filename = './datasets/2.jpg';
% filename = './datasets/3.png';
% filename = './datasets/4.jpg';
% filename = './datasets/5.jpg';
Img = imread(filename);
Img = (Img(:,:,1));
[row,col] = size(Img);

%% compute texture feature & roughness feature & intensity feature
F_tex = entropyfilt(Img);
F_rou = Stdfilt(Img, 3);
F_int = double(Img);

%% Initialization of level set function
[nx,ny]=size(F_int);
x0 = round(ny/2);
y0 = round(nx/2);
r1 = y0 - 40;
r2 = y0 + 40;
c1 = x0 - 40;
c2 = x0 + 40;
u= ones(row,col);
u(r1:r2,c1:c2) = -1;
figure(1);
imshow(F_int, [0,255]);
hold on;
axis off;
[c, h] = contour(u, [0 0], 'g','LineWidth',2);
title('Initial contour');

tic;
while (1)
    [ux, uy] = gradient(u);
    H_u = 0.5*(1+(2/pi)*atan(u/epsilon));
    delta_H = (1/pi)*epsilon./(epsilon^2+u.^2);
    
    %% begin to calculate the SPF of each feature
    [g_in_int, g_out_int, l_in_int, l_out_int] = Feature_extraction(F_int, Gb, H_u,u);
    f_in_int = lambda * g_in_int + (1 - lambda) * l_in_int;
    f_out_int = lambda * g_out_int + (1-lambda) * l_out_int;
    Fit_int = f_in_int .* H_u + f_out_int .* (1 - H_u);
    spf_int = F_int - Fit_int;
    
    [g_in_tex, g_out_tex, l_in_tex, l_out_tex] = Feature_extraction(F_tex,Gb,H_u,u);
    f_in_tex = lambda * g_in_tex + (1-lambda) * l_out_tex;
    f_out_tex = lambda *g_out_tex + (1-lambda) * l_out_tex;
    Fit_tex = f_in_tex .* H_u + f_out_tex .* (1-H_u);
    spf_tex = F_tex - Fit_tex;
    
    [g_in_rou, g_out_rou, l_in_rou, l_out_rou] = Feature_extraction(F_rou,Gb,H_u,u);
    f_in_rou = lambda * g_in_rou + (1-lambda) * l_out_rou;
    f_out_rou = lambda  * g_out_rou + (1-lambda) * l_out_rou;
    Fit_rou = f_in_rou .* H_u + f_out_rou .* (1 - H_u);
    spf_rou = F_rou - Fit_rou;
    
    %% evolve the level set function u
    spf_total = spf_int + spf_tex + spf_rou;
    spf_total = spf_total / (max(abs(spf_total(:)))); % regularized to [0,1]
    u = u + (alpha * spf_total.* sqrt( ux.^2 + uy.^2 ));
    u = (u >= 0) - ( u< 0);
  
   %% judge if the level set function u is converged
    if n >= iter
        break;
    end 
    u = conv2(u, Gr, 'same');   
    if mod(n,1) == 0 
        imagesc(F_int, [0 255]); colormap(gray); hold on; axis off;
        [c, h] = contour(u, [0 0], 'r','LineWidth',2);
        iterNum = [num2str(n), 'iterations'];
        title(iterNum);
        pause(0.01);
    end
    n = n + 1;
end
toc
%% Output the binary image
u = conv2(u, Gr, 'same');
u = (u >= 0) - ( u< 0);
bw = u;
bw(bw<0) = 0; 

%% Output the result of contour extraction
figure(2);
imagesc(Img,[0 255]); colormap(gray);
hold on;
axis off;
[c, h] = contour(u, [0 0], 'r','LineWidth',2); 
figure(3);
imshow(bw);


   
