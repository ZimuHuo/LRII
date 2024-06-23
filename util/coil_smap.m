function [s,rms] = coil_smap(x,xref)
% Compute coil sensitivity maps 
%  [s,rms] = coil_smap(xn,xd);

dims = size(xref);
NC = numel(x) / numel(xref);  % number of coils
dims = [dims NC];
x = reshape(x,prod(dims(1:end-1)),NC);
rms = sqrt(mean(abs(x).^2,2));

if nargin == 1 || (nargin >1 && isempty(xref)),
  xref =  rms;
else 
  xref = reshape(xref,prod(dims(1:end-1)),1);
end

if nargin == 3,
  % low-pass filter
  if (length(dims) == 4), % [x y z coils]
    Wx = hamming(dims(1));
    Wy = hamming(dims(2));
    Wz = hamming(dims(3));
    W = Wy*Wz';
    W = repmat(reshape(W,[1 dims(2) dims(3)]),[dims(1) 1 1]);
  elseif (length(dims) == 3), % [y z coils]
    Wy = hamming(dims(1));
    Wz = hamming(dims(2));
    W = Wy*Wz';
  end
  xref = reshape(xref,dims(1:end-1));
  xref = ktoi(itok(xref).*W);
  xref = reshape(xref,prod(dims(1:end-1)),1);
  for coil=1:NC,
    xt = reshape(x(:,coil),dims(1:end-1));
    xt = ktoi(itok(xt).*W);
    x(:,coil) = reshape(xt,prod(dims(1:end-1)),1);
  end
end

%xref = repmat(xref,[1 NC]);
I = find(abs(xref) > 0.01*max(abs(xref(:)))); % 1e-2

s = 0*x;
for coil=1:NC,
  s(I,coil) = x(I,coil) ./ xref(I);
end

s = reshape(s,dims);
rms = reshape(rms,dims(1:end-1));

return