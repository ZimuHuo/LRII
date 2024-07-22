function n = gaussian_noise(shape, mu, sigma)
% Author: Zimu Huo
% Date: 2024-01-02
    n = complex(normrnd(mu, sigma, shape),normrnd(mu, sigma, shape));
end
