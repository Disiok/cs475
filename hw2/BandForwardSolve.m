function x = BandForwardSolve(L, b, p)
    n = size(b, 1);
    x = zeros(n, 1);
    x(1) = b(1) / L(1, 1);
    for i = 2:n
        x(i) = (b(i) - L(i, max(1, i - p):(i-1)) * x(max(1, i - p):(i-1))) / L(i, i);
    end
end 
