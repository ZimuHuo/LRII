function coil_array = coilmap(imageSize, ncoils, array_cent, coil_width, n_rings, phi)
    if nargin < 6
        phi = 0;
    end

    if nargin < 5
        n_rings = floor(ncoils / 4);
    end

    if nargin < 4
        coil_width = imageSize(1)/4;
    end

    if nargin < 3 || isempty(array_cent)
        c_shift = [0, 0, 0];
    else
        c_shift = array_cent;
    end

    c_width = coil_width * min(imageSize);

    c_rad = min(imageSize(1:2)) / 2;
    smap = zeros([imageSize, ncoils]);

    [yy, xx, zz] = ndgrid(1:imageSize(2), 1:imageSize(1), 1:imageSize(3));

    x0 = zeros(ncoils, 1);
    y0 = zeros(ncoils, 1);
    z0 = zeros(ncoils, 1);

    for i = 1:ncoils
        theta = deg2rad((i - 1) * 360 / (ncoils + n_rings) + phi);
        x0(i) = c_rad * cos(theta) + imageSize(1) / 2;
        y0(i) = c_rad * sin(theta) + imageSize(2) / 2;
        z0(i) = (imageSize(3) / (n_rings + 1)) * floor((i - 1) / n_rings);
        smap(:, :, :, i) = exp(-((xx - x0(i)).^2 + (yy - y0(i)).^2 + (zz - z0(i)).^2) / (2 * c_width));
    end

    side_mat = (floor(imageSize(1) / 2) - 20):-1:1;
    side_mat = (reshape(side_mat, [1, numel(side_mat)]) .* ones([imageSize(2), 1])) / 5;
    cent_zeros = zeros([imageSize(2), imageSize(1) - size(side_mat, 2) * 2]);

    ph = cat(2, side_mat, cent_zeros, side_mat);
    ph = reshape(ph, [1, size(ph)]);
    
    for i = 1:ncoils
        smap(:, :, :, i) = smap(:, :, :, i) .* exp(1i * (i - 1) * ph * pi / 180);
    end
    
    coil_array = permute(smap, [2, 1, 3, 4]);
end
