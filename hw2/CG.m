function [x, iter] = CG(A, b, x_initial, maxiter, tol)
    x = x_initial;
    g = A' * (A * x) - (A' * b);
    d = g;

    function result = is_converged(g)
        result = norm(g) <= tol;
    end

    for iter=1:maxiter
        if is_converged(g)
            break
        end

        Sd = A'* (A * d);
        eda = (g' * d)/(d' * Sd);
        x = x - eda * d;
        g = g - eda * Sd;
        beta = (g' * Sd) / (d' * Sd);
        d = g - beta * d;
    end
end
