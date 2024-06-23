function res = ifft1(x)

res = sqrt(length(x)).*fftshift(ifft(ifftshift(x)));
end
