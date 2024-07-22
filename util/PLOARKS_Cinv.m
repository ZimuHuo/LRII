function mat = PLOARKS_Cinv(data, k, shape)
% Author: Zimu Huo
% Date: 2024-01-02
    ny = shape(1);
    nx = shape(2);
    nz = shape(3);
    nc = shape(4);
    [nt, ks] = size(data);
    data = reshape(data, [nt, k, k, k, nc]);
    mat = complex(zeros([ny, nx, nz, nc]));
    count = zeros([ny, nx, nz, nc]);
    idx = 1;
    for y =  1:ny - k  + 1 
        for x = 1:nx - k  + 1 
            for z = 1:nz - k  + 1 
                mat(y:y+k-1, x:x+k-1, z:z+k-1,:) = mat(y:y+k-1, x:x+k-1, z:z+k-1,:) + squeeze(data(idx, :, :, :, :));
                count(y:y+k-1, x:x+k-1, z:z+k-1,:) = count(y:y+k-1, x:x+k-1, z:z+k-1,:) + 1;
                idx = idx + 1;
            end
        end
    end
    mat = mat ./ count;
    % mat = permute(mat, [2, 3, 4, 1]);
end
