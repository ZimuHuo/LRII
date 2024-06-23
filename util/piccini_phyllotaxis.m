function traj = piccini_phyllotaxis(n, nint)
    % Generate a spiral phyllotaxis trajectory with square root z-modulation
    % according to formulation by Piccini et al. Note, this does not give a uniform
    % FOV but slightly higher sampling in the x/y plane than along z.
    %
    % Args:
    %    n (int): Number of spokes
    %    nint (int): Number of interleaves
    %
    % Returns:
    %    [array]: Trajectory
    %
    % References:
    %    Piccini D, et al., Magn Reson Med. 2011;66(4):1049–56.

    % Constants
    PHI_GOLD = (1 + sqrt(5)) / 2; % Golden ratio
    
    % Check inputs
    if mod(n, 2) ~= 0
        error('Number of spokes must be even');
    end
    
    fibonacciNum = [0, 1]; % Initializing Fibonacci numbers
    while fibonacciNum(end) < nint
        fibonacciNum(end+1) = fibonacciNum(end) + fibonacciNum(end-1); % Generating Fibonacci numbers
    end
    
    if ~ismember(nint, fibonacciNum)
        error('Number of interleaves has to be a Fibonacci number');
    end

    if mod(n, nint) ~= 0
        error('Spokes per interleave must be an integer number');
    end
    
    spokes_per_int = round(n/nint);
    traj_tmp = zeros(n, 3);
    traj = zeros(n, 3);
    
    % Calculate trajectory
    for i = 1:n
        if i <= n/2
            theta_n = pi/2 * sqrt((i-1)/(n/2));
            gz_sign = 1;
        else
            theta_n = pi/2 * sqrt((n-i)/(n/2));
            gz_sign = -1;
        end
        
        phi_n = (i-1) * PHI_GOLD;
        traj_tmp(i, 1) = sin(theta_n) * cos(phi_n);
        traj_tmp(i, 2) = sin(theta_n) * sin(phi_n);
        traj_tmp(i, 3) = gz_sign * cos(theta_n);
    end
    
    % Stack the interleaves after each other
    for i = 1:nint
    if mod(i-1, 2) == 0
        for j = 1:spokes_per_int
            idx1 = (i-1) * spokes_per_int + j;
            idx2 = (i-1) + (j-1) * nint + 1;
            traj(idx1, :) = traj_tmp(idx2, :);
        end
    else
        for j = 1:spokes_per_int
            idx1 = (i-1) * spokes_per_int + j;
            idx2 = (n - (nint - (i-1))) - (j-1) * nint + 1;
            traj(idx1, :) = traj_tmp(idx2, :);
        end
    end
    end


end
