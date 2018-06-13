function [x, iter] = SOR(omega, A, b, x_initial, maxiter, tol)
    x = x_initial;

    function result = is_converged(r)
        result = norm(r) <= tol * norm(b);
    end

    D = diag(diag(A));
    L = tril(A);
    DL_inv = inv(D / omega + L);

    for iter=1:maxiter
        r = (b - A * x);

        if (mode(iter, 1000) == 1)
            if is_converged(r)
                break
            end
        end

        x = x + DL_inv * r;
    end
end
