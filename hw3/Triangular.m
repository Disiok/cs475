function [B, Q] = Triangular(A)
    [n, _] = size(A);
    for j = 1:n-2
        [v, beta] = House(A(j+1:n, j));
        A(j+1, j) = norm(A(j+1:n, j));
        A(j, j+1) = A(j+1, j);
        w = beta * A(j+1:n, j+1:n) * v;
        u = w - (beta / 2 * w' * v) * v;
        delta = u * v';
        A(j+1:n, j+1:n) = A(j+1:n, j+1:n) - delta - delta';
        A(j+2:n,j) = v(2:end);
    end
    B = spdiags(spdiags(A, -1:1), -1:1, n, n);

    % Recovering Q
    Q = eye(n);
    for j=n-2:-1:1
        v = vertcat([1], A(j+2:n, j));
        beta = 2 / norm(v) ^ 2;
        Q(j+1:n, j+1:n) = Q(j+1:n, j+1:n) - (beta * v) * (v' * Q(j+1:n, j+1:n));
    end
end
