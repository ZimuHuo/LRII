
function inspect_rank(data, rank)
% Author: Zimu Huo
% Date: 2024-01-02
    [U,S,VT] = svdsecon(data, rank);
    s = diag(S);
    s = s ./ max(s(:));
    index = find(s > 0.01, 1, 'last');
    yval = s(index);
    
    fprintf('rank: %d\n', index);
    
    figure;
    subplot(2,1,1);
    plot(diag(S) / max(diag(S)));
    hold on;
    plot([0, length(diag(S))], [yval, yval], 'r-');
    title('Singular Values');
    
    subplot(2,1,2);
    imagesc(abs(VT));
    axis equal;
    colormap('gray');
end
