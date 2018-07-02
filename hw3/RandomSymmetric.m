function A = RandomSymmetric(n)
    d = 1000 * rand(n, 1); % The diagonal values
    t = triu(bsxfun(@min, d, d') .* rand(n), 1); % The upper trianglar random values
    A = diag(d) + t + t'; % Put them together in a symmetric matrix
end
