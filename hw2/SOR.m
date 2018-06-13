function [x, iter] = SOR(omega, A, b, x_initial, maxiter, tol)
    n = size(x_initial, 1);
    m = sqrt(n);
    x = x_initial;

    function result = is_converged(r)
        result = norm(r) <= tol * norm(b);
    end

    D = diag(diag(A) / omega);
    L = tril(A);

    for iter=1:maxiter
        r = (b - A * x);

        if (mod(iter, 10) == 1)
            if is_converged(r)
                break
            end
        end

        delta = BandForwardSolve(D + L, r, m);
        x = x + delta;
    end
end
