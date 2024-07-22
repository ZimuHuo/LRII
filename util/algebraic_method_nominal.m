function filled_zte_data = algebraic_method_nominal(unfilled_zte_data, nominal_gap,  oversampled_gap, nRO, nTR)
% Author: Zimu Huo
% Date: 2024-01-02
unfilled_zte_data = reshape(unfilled_zte_data, nRO, nTR, []);
[nRO, nTR, nc] = size(unfilled_zte_data);
l = nRO * 2- 1; 
T = ones(l, 1);
T(l/4:l/4+l/2) = 0;
T = diag(T);

C = ones(l, 1);
C(l/2-nominal_gap/2:l/2+nominal_gap) = 0;
C = diag(C);
% F = dftmtx(l);
F = dftmtx(l+nominal_gap-1);
rows_to_remove = 2:2:oversampled_gap;
F(rows_to_remove, :) = [];
F(:, rows_to_remove) = [];
F_inv = pinv(F);
A = C * F * T;
A_inv = F * pinv(A, 1e-6);
textprogressbar('computing nth TR: ')
filled_zte_data = reshape(unfilled_zte_data, nRO, nTR, nc);
for TR = 1:nTR/2
    textprogressbar(TR)
    for coil = 1:nc
        pos = gather(squeeze(filled_zte_data(:,TR,coil)));
        neg = gather(squeeze(filled_zte_data(:,TR+nTR/2,coil)));
        neg = neg(end:-1:1);
        combined = cat(1, neg(1:end-1), pos);
        radial = A_inv * combined; 
        neg = radial(1:nRO);
        neg = neg(end:-1:1);
        pos = radial(end-nRO+1:end); 
        filled_zte_data(1:nominal_gap,TR, coil) = pos(1:nominal_gap);
        filled_zte_data(1:nominal_gap,TR+nTR/2,coil) = neg(1:nominal_gap);
    end
end
textprogressbar('Done')
end