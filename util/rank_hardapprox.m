function approx = rank_hardapprox(data, rank)
    [U, S, V] = svdsecon(data, rank);
    approx = U(:, 1:rank) * S(1:rank, 1:rank) * V(:, 1:rank)';
end
