function A = dftmtx_custom(n)
    % Check for valid input
    if ~isnumeric(n) || ~isscalar(n) || n <= 0 || rem(n, 1) ~= 0
        error('Input must be a positive integer scalar.');
    end
    
    % Create empty matrix for DFT
    A = zeros(n);
    
    % Calculate the DFT matrix
    for k = 0:n-1
        for m = 0:n-1
            A(m+1, k+1) = exp(-2*pi*1i*m*k/n) / sqrt(n);
        end
    end
end
