function EigenMethods()
    tol = 1e-4;
    maxiter = 10000;
    n = 100;
    A = Tridiagonal(n);

    figure();
    v0 = vertcat([1], zeros(n - 1, 1));
    [v, lambda, iter] = PowerIteration(A, v0, maxiter, tol);
    plot(v);
    format_str = sprintf("Largest eigenvector with eigenvalue %f after %d iters of PowerIteration", lambda, iter);
    title(format_str);

    figure();
    v0 = ones(n, 1);
    [v, lambda, iter] = RayleighQuotient(A, v0, maxiter, tol);
    plot(v);
    format_str = sprintf("Largest eigenvector with eigenvalue %f after %d iters of RayleighQuotient", lambda, iter);
    title(format_str);

    figure();
    [V, Lambda, iter] = QRIteration(A, maxiter, tol);
    plot(diag(Lambda));
    title("All eigenvalues");

    for i = 1:4
        ind = i * 20;
        figure();
        plot(V(:, ind));
        format_str = sprintf("%dth eigenvector with eigenvalue %f after %d iters of QRIteration", ind, diag(Lambda)(ind), iter);
        title(format_str);
    end
end
