clear;
clc;

addpath("parallel/")
addpath("util/")
addpath("svd/")
addpath("data/")

[tissues, tissuetype, T2] = get_tissue_images();
[ny, nx, nz, nt] = size(tissues);
TE = 100;
ideal_image = zeros([ny, nx, nz]);
for t = 1:nt
    ideal_image = ideal_image + tissues(:,:,:,t) * exp(TE/T2(t));
end
ideal_image = ideal_image ./ max(ideal_image(:));
N = 256;
ny = N; nx = N; nz = N;
image = zpad3(ideal_image, [ny, nx, nz]);
image = image(1:2:end,1:2:end,1:2:end);
[ny, nx, nz] = size(image);
N = ny;
nc = 4;
maps = coilmap([ny, nx, nz], nc);
image = repmat(image, 1,1,1,nc);
traj =load("util/traj.mat").traj;

obj = nufft_3d(traj,N,'gpu',1);
data = obj.fNUFT(image);

im1 = obj.iNUFT(data, 20);
imsos1 = sos(im1);

ndata = data + gaussian_noise(size(data), 0, 1e2);

im2 = obj.iNUFT(ndata, 20);
imsos2 = sos(im2);

usegpu = 1; 
TV = TV_operator('3D',usegpu);
param.maxit  = 20;
param.step   = 0.02;  % initial stepsize
param.lambda = 0.05; % TV regularisation weight
param.backtrack = true; % backtracking adaptive step size search
im3 = solve_TV(ndata, obj, TV, param);
imsos3 = sos(im3);

% volumeViewer(imsos1);
figure
subplot(131)
imshow(imsos1(:,:,60),[]), colorbar()
title(string(l2(imsos1, imsos1)))
subplot(132)
imshow(imsos2(:,:,60),[]), colorbar()
title(string(l2(imsos2, imsos1)))
subplot(133)
imshow(imsos3(:,:,60),[]), colorbar()
title(string(l2(imsos3, imsos1)))