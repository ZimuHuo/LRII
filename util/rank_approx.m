
function approx = rank_approx(data, rank)
% Author: Zimu Huo
% Date: 2024-01-02
    [U, S, VT] = svds(data, rank);
    approx = U(:, 1:rank) * S(1:rank, 1:rank) * VT(:, 1:rank)';
end

