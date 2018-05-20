function x = Cholesky(A, b)
    n = size(b, 1);
    L = CholeskyFact(A);
    U = L';
    y = ForwardSolve(L, b);
    x = BackwardSolve(U, y);
end
