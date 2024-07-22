
function approx = rank_approxthres(data, thres)
% Author: Zimu Huo
% Date: 2024-01-02
    [U, S, VT] = svd(data, 'econ');
    s = diag(S);
    s = s ./ max(s(:));
    rank = find(s > thres, 1, 'last');
    approx = U(:, 1:rank) * S(1:rank, 1:rank) * VT(:, 1:rank)';
end

