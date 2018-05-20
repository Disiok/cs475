function [L, U] = LUFact(A)
    n = size(A, 1);
    for j = 1:n-1
        for i = j+1:n
            A(i, j) = A(i, j) / A(j, j);
            A(i,j+1:n) = A(i,j+1:n) - A(i,j) * A(j,j+1:n);
        end
    end
    L = tril(A, -1) + eye(n);
    U = triu(A);
end
