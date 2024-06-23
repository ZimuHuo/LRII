function res = fft1(x)

%x ... k-space data with dimension [Ny, Nx, Ncoil] 

res = zeros(size(x));

for i = 1:size(x,2) 
    temp = x(:,i);
    res(:,i) = 1/sqrt(length(temp(:))).*fftshift(fft2(ifftshift(temp)));
end
