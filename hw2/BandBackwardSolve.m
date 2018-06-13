function x = BandBackwardSolve(U, b, q)
    n = size(b, 1);
    x = zeros(n, 1);
    x(n) = b(n) / U(n, n);
    for i = (n-1):-1:1
        x(i) = (b(i) - U(i, (i+1):min(n, i + q)) * x((i+1):min(n, i + q))) / U(i, i);
    end 
end
