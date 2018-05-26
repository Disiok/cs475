function CompareNNZ()

for i = 1:4
    m = 10 * 2 ^ i;
    disp('Grid size: ');
    disp(m);

    ordering_method = 'natural';
    [A, b] = ReorderLap2D(m, ordering_method);
    [L, U] = lu(A);
    n_nonzeros = nnz(L);
    disp(n_nonzeros);
    n_nonzeros = nnz(A);
    disp(n_nonzeros);

    ordering_method = 'rcm';
    [A, b] = ReorderLap2D(m, ordering_method);
    [L, U] = lu(A);
    n_nonzeros = nnz(L);
    disp(n_nonzeros);
    n_nonzeros = nnz(A);
    disp(n_nonzeros);

    ordering_method = 'min';
    [A, b] = ReorderLap2D(m, ordering_method);
    [L, U] = lu(A);
    n_nonzeros = nnz(L);
    disp(n_nonzeros);
    n_nonzeros = nnz(A);
    disp(n_nonzeros);
end 
