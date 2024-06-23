function n = gaussian_noise(shape, mu, sigma)
    if nargin < 2
        mu = 0;
    end
    
    if nargin < 3
        sigma = 1;
    end
    
    n = zeros(shape, 'like', 1i);  % Initialize as complex
    n = complex(normrnd(mu, sigma, shape(1), shape(2)),normrnd(mu, sigma, shape(1), shape(2)));
end
