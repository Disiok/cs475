function L = CholeskyFact(A)
    n = size(A, 1);
    for j = 1:n
        for i = j+1:n
            A(i:n, i) = A(i:n, i) - (A(i,j) / A(j, j)) * A(i:n, j);
        end
        A(j:n, j) = A(j:n, j) / sqrt(A(j, j));
    end
    L = tril(A);
end
