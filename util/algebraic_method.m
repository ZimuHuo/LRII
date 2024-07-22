function filled_zte_data = algebraic_method(unfilled_zte_data, gap, nRO, nTR)
% Author: Zimu Huo
% Date: 2024-01-02
unfilled_zte_data = reshape(unfilled_zte_data, nRO, nTR, []);
[nRO, nTR, nc] = size(unfilled_zte_data);
l = nRO * 2- 1; 
T = ones(l, 1);
T(ceil(l/4):floor(l/4+l/2)) = 0; % slightly conservative? 
T = diag(T);

C = ones(l, 1);
C(ceil(l/2-gap/2):floor(l/2+gap)) = 0;
C = diag(C);

F = dftmtx_custom(l);
F_inv = pinv(F);
A = C * F * T;
A_inv = F * pinv(A, 1e-6);
% textprogressbar('computing nth TR: ')
filled_zte_data = reshape(unfilled_zte_data, nRO, nTR, nc);
for TR = 1:nTR/2
    % textprogressbar(TR)
    for coil = 1:nc
        pos = gather(squeeze(filled_zte_data(:,TR,coil)));
        neg = gather(squeeze(filled_zte_data(:,TR+nTR/2,coil)));
        neg = neg(end:-1:1);
        combined = cat(1, neg(1:end-1), pos);
        radial = A_inv * combined; 
        neg = radial(1:nRO);
        neg = neg(end:-1:1);
        pos = radial(end-nRO+1:end); 
        filled_zte_data(1:gap,TR, coil) = pos(1:gap);
        filled_zte_data(1:gap,TR+nTR/2,coil) = neg(1:gap);
    end
end
% textprogressbar('Done')
end

% this is the code i used to debug the code, the following shows the
% algebraic method is able to perfectly recover the missing data when the
% gap is 3. See line 120 on this script. 
% clear;
% clc;
% 
% addpath("util/")
% addpath("svd/")
% addpath("bart/")
% 
% N = 64;              % FOV    
% ny = N; nx = N; nz = N;
% nc = 4;
% gap = 0; % set 0 for now to get ground truth
% 
% 
% brain = get_brain_phantom(100);
% brain = brain(1:2:end,1:2:end,1:2:end);
% brain = brain(1:2:end,1:2:end,1:2:end);
% 
% % volumeViewer(abs(brain));
% 
% traj = piccini_phyllotaxis(floor(N * N), 1);
% traj = traj2points(traj, N, 2);
% traj = permute(traj, [3, 2, 1]);
% traj1 = traj(:,:,1);
% traj = cat(3, traj1, -traj1);
% [ndim, nRO, nTR]=size(traj);
% sensMap = coilmap([N,N,N], nc, 64);
% coil_image = repmat(brain,1,1,1,nc) .* sensMap;
% object_mask = coil_image;
% object_mask(object_mask > 0) = 1; 
% % volumeViewer(sos(coil_image))
% clear sensMap
% 
% %% ground_truth
% disp("computing ground truth")
% obj = nufft_3d(traj,N,'gpu',2);
% data = obj.fNUFT(coil_image);
% ground_truth = obj.iNUFT(data, 0);
% 
% %% Noisy SNR 20 std 85; SNR 15 std 150 ; SNR 10 std 260 ; SNR 5 std = 500
% std = 0;
% disp("computing noisy realisation")
% noise = gaussian_noise(size(data),0, std); 
% noisy_data = data + noise;                                                                                                                          
% SNR = snr(abs(ground_truth), obj.iNUFT(noise, 0));
% noisy_images = obj.iNUFT(noisy_data, 0);
% l2(noisy_images , ground_truth)
% 
% %% zero_filled
% disp("computing zero filled")
% unfilled_zte_data = reshape(noisy_data, nRO, nTR, nc);
% obj.nTR = nTR;
% obj.nRO = nRO;
% obj.gap = gap;
% unfilled_zte_data(1:gap,:,:) = 0;
% zero_filled = obj.iNUFT(unfilled_zte_data, 0);
% l2(zero_filled , ground_truth)
% 
% %% 
% disp("computing algebraic")
% a = gather(unfilled_zte_data(:,:,1));
% 
% l = nRO * 2- 1; 
% T = ones(l, 1);
% T(l/4:l/4+l/2) = 0;
% T = diag(T);
% 
% C = ones(l, 1);
% C(l/2-gap/2:l/2+gap) = 0;
% C = diag(C);
% 
% F = dftmtx_custom(l);
% F_inv = pinv(F);
% A = C * F * T;
% A_inv = F * pinv(A, 1e-3);
% 
% pos = (squeeze(a(:,1)));
% neg = (squeeze(a(:,2)));
% neg = neg(end:-1:1);
% combinedgt = cat(1, neg(1:end-1), pos);
% 
% gap = 3;
% unfilled_zte_data(1:gap,:,:) = 0;
% a = gather(unfilled_zte_data(:,:,1));
% 
% l = nRO * 2- 1; 
% T = ones(l, 1);
% T(l/4:l/4+l/2) = 0;
% T = diag(T);
% 
% C = ones(l, 1);
% C(l/2-gap/2:l/2+gap) = 0;
% C = diag(C);
% 
% F = dftmtx_custom(l);
% F_inv = pinv(F);
% A = C * F * T;
% A_inv = F * pinv(A, 1e-6);
% 
% pos = (squeeze(a(:,1)));
% neg = (squeeze(a(:,2)));
% neg = neg(end:-1:1);
% combined = cat(1, neg(1:end-1), pos);
% radial = A_inv * combined; 
% 
% 
% figure()
% plot(abs(combinedgt))
% hold on
% plot(abs(radial), '--')
% legend(["ground truth", "recon"])
% 
% 
