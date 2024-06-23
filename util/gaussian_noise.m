function n = gaussian_noise(shape, mu, sigma)
    n = complex(normrnd(mu, sigma, shape),normrnd(mu, sigma, shape));
end
