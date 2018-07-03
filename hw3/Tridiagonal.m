function A = Tridiagonal(n)
    sub_d_vec = ones(n - 1, 1) * -1;
    d_vec = ones(n, 1) * 2;
    A = diag(d_vec) + diag(sub_d_vec, -1) + diag(sub_d_vec, 1);
end
