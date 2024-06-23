function res = ifft2(x)

res = zeros(size(x));

for i = 1:size(x,3) 
    temp = x(:,:,i);
    res(:,:,i) = sqrt(length(temp(:))).*fftshift(ifft2(ifftshift(temp)));
end
