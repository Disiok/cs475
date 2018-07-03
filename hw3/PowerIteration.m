function [q, lambda, iter] = PowerIteration(A, q0, maxiter, tol)
    [B, Q] = Triangular(A);
    q = q0 / norm(q0);
    for iter = 1:maxiter
        z = B * q;
        lambda = q' * z;
        s = norm(z);
        if (s^2 <= tol ^ 2 / 2 + lambda ^ 2)
            break;
        end
        q = z / s;
    end
    q = Q * q;
end
