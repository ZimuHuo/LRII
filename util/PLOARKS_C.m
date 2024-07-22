function mat = PLOARKS_C(data, k)
% Author: Zimu Huo
% Date: 2024-01-02
    [ny, nx, nz, nc] = size(data);
    %data = permute(data, [4, 1, 2, 3]);
    mat = complex(zeros([(ny-k+1)*(nx-k+1)*(nz-k+1), k * k * k * nc]));
    idx = 1;
    for y = 1:ny - k + 1 
        for x =1:nx - k  + 1 
            for z = 1:nz - k  + 1 
                mat(idx, :) = reshape(data(y:y+k-1, x:x+k-1, z:z+k-1,:), 1, []);
                idx = idx + 1;
            end
        end
    end
end
