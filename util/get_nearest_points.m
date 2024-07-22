function points = get_nearest_points(traj, cur_location, nk)
% Author: Zimu Huo
% Date: 2024-01-02
    if nargin < 3
        nk = 5;
    end

    kdtree = KDTreeSearcher(traj.');
    [points, ~] = knnsearch(kdtree, cur_location.', 'K', nk);
end
