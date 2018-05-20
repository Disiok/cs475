function [L, U] = BandLUFact(A, p, q)
    n = size(A, 1);
    for j = 1:n-1
        for i = j+1:min(n, j + p)
            A(i, j) = A(i, j) / A(j, j);
            A(i,j+1:min(n, j + q)) = A(i,j+1:min(n, j + q)) - A(i,j) * A(j,j+1:min(n, j + q));
        end
    end
    L = tril(A, -1) + eye(n);
    U = triu(A);
end
