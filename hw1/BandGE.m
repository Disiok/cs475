function x = BandGE(A, b)
    n = sqrt(size(b, 1));
    [L, U] = BandLUFact(A, n, n);
    y = BandForwardSolve(L, b, n);
    x = BandBackwardSolve(U, y, n);
end
