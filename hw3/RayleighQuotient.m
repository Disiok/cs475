function [q, lambda, iter] = RayleighQuotient(A, q0, maxiter, tol)
    [n, _] = size(A);
    [B, Q] = Triangular(A);
    q = q0 / norm(q0);
    miu = q0' * (B * q0);
    for iter = 1:maxiter
        z = (B - miu * eye(n)) \ q;
        s = norm(z);
        lambda = q' * z / s ^ 2 + miu;
        q = z / s;
        if (1 <= s ^ 2 * (tol ^ 2 / 2 + (lambda - miu) ^ 2))
            break;
        end
        miu = lambda;
    end
    q = Q * q;
end
