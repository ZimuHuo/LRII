function points = get_nearest_points(traj, cur_location, nk)
    if nargin < 3
        nk = 5;
    end

    kdtree = KDTreeSearcher(traj.');
    [points, ~] = knnsearch(kdtree, cur_location.', 'K', nk);
end
