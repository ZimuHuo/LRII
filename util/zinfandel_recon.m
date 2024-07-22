function [zinfandel_data] = zinfandel_recon(zinfandel_data, traj, gap, nk, nl, ns)
% Author: Zimu Huo
% Date: 2024-01-02
if nargin < 3
    nk = 5;
end
if nargin < 4
    nl = 16;
end
if nargin < 5
    ns = 3;
end



[nRO, nTR, nc] = size(zinfandel_data);
[ndim, nRO, nTR] = size(traj);

kdtree = KDTreeSearcher(squeeze(traj(:,gap+1,:)).');
for RO= gap:-1:1
    % textprogressbar('calculating outputs: ');
    for TR =nTR:-1:1
       % textprogressbar(TR);
       cur_location = squeeze(traj(:, gap+1, TR));
       [index, ~] = knnsearch(kdtree, cur_location.', 'K', nk);
       calib_data = zinfandel_data(RO+1:RO+1+nl, index, : );
       w = train_zinfandel_kernel(calib_data, ns);
       source_points = reshape(zinfandel_data(RO + 1:RO + ns, TR,  :), 1, []);
       zinfandel_data(RO, TR, :) = source_points * w;

    end
    % textprogressbar('done');


end

end

function weight = train_zinfandel_kernel(calib_data, ns, lamda)
    if nargin < 3
        lamda = 0;
    end

    [nx, ny, nc] = size(calib_data);
    source = zeros(ny * (nx - ns), ns * nc);
    target = zeros(ny * (nx - ns), nc);
    n = 1;

    for x = 1:(nx - ns)
        for y = 1:ny
            target(n, :) = reshape(calib_data(x, y, :), [1, nc]);
            source(n, :) = reshape(calib_data(x + 1 : x + ns, y, :), [1, ns * nc]);
            n = n + 1;
        end
    end

    if lamda
        % [u, s, vh] = svd(source, 'econ');
        % s_inv = conj(s) ./ (abs(s).^2 + lamda);
        % inMat_inv = vh * diag(s_inv) * u';
        % weight = (inMat_inv * target');
        weight = pinv(source, lamda) * target;
    else
        weight = pinv(source) * target;
    end
end
