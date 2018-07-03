function [V, Lambda, iter] = QRIteration(A, maxiter, tol)
    [n, _] = size(A);
    [Lambda0, Q0] = Triangular(A);
    Lambda = Lambda0;
    V = eye(n);
    for iter = 1:maxiter
        [Q, R] = qr(Lambda);
        Lambda = R * Q;
        V = V * Q;
        if (all(vecnorm(Lambda0 * V - diag(Lambda)' .* V) < tol ^ 2 ))
            break;
        end
    end
    V = Q0 * V;
end
