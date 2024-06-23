function traj_p = traj2points(traj, npoints, OS)
    % Transform spoke trajectory to point trajectory
    %
    % Args:
    %    traj: Trajectory with shape [nspokes, 3]
    %    npoints: Number of readout points along spokes
    %    OS: Oversampling
    %
    % Returns:
    %    array: Trajectory with shape [nspokes, npoints, 3]

    [nspokes, ndim] = size(traj);

    r = (0:npoints-1) / OS;
    traj_p = zeros(nspokes, npoints, ndim);

    for i = 1:ndim
        % Expand r to match the size of traj for broadcasting
        r_expanded = repmat(r, nspokes, 1);
        % Direct multiplication and reshaping for each dimension
        traj_p(:,:,i) = r_expanded .* repmat(traj(:,i), 1, npoints);
    end
end
