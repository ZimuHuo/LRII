function [brain] = get_brain_phantom(TE)
% Author: Zimu Huo
% Date: 2024-01-02
    [tissues, tissuetype, T2] = get_tissue_images();
    [ny, nx, nz, nt] = size(tissues);
    ideal_image = zeros([ny, nx, nz]);
    for t =1:4
        ideal_image = ideal_image +  tissues(:,:,:,t) .* exp(TE/T2(t));
    end
    images = ideal_image;
    brain = zpad3(images, [256,256,256]);
end
