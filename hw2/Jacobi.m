function [x, iter] = Jacobi(A, b, x_initial, maxiter, tol)
    n = size(x_initial, 1);
    m = sqrt(n);
    x = x_initial;

    function result = is_converged(r)
        result = norm(r) <= tol * norm(b);
    end

    D_inv = diag(1./diag(A));

    for iter=1:maxiter
        r = (b - A * x);

        if (mod(iter, 1000) == 1)
            if is_converged(r)
                break
            end
        end

        x = x + D_inv * r;
    end
end
