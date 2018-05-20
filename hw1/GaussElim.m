function x = GaussElim(A, b)
    n = size(b, 1);
    [L, U] = LUFact(A);
    y = ForwardSolve(L, b);
    x = BackwardSolve(U, y);
end
