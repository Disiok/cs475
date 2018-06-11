function A = ImageMatrix(u)
    % Hyper parameters
    alpha = 4 * 10 ^ (-2);
    beta = 10 ^ (-6);
    h = 16;

    % Input
    m = size(u, 1);
    n = m ^ 2;

    % Setup
    A = zeros(n);
    A = sparse(A);
    AW = zeros(m, m);
    AE = zeros(m, m);
    AS = zeros(m, m);
    AN = zeros(m, m);
    AC = zeros(m, m);

    % For boundary checking
    function result=v(i, j)
        if (i <= m && i >= 1 && j <= m && j >= 1)
            result = u(i, j);
        else
            result = 0;
        end
    end

    function result = sub(a, b, c, d)
        result = 1 / (2 * sqrt(((a - b) / h) ^ 2 + ((c - d) / h) ^ 2 + beta));
    end

    function result = main(a, b, c, d, e, f, g, i)
        p = - alpha / (h ^ 2);
        result = p * (sub(a, b, c, d) + sub(e, f, g, i));
    end

    % For indexing
    function k = r(i, j, m)
        k = (j - 1) * m + i;
    end

    for i = 1:m
        for j = 1:m
            AW(i, j) = main(v(i, j), v(i - 1, j), v(i, j), v(i, j - 1), v(i, j), v(i - 1, j), v(i - 1, j + 1), v(i - 1, j));
            AE(i, j) = main(v(i + 1, j), v(i, j), v(i + 1, j), v(i + 1, j - 1), v(i + 1, j), v(i, j), v(i, j + 1), v(i, j));
            AS(i ,j) = main(v(i, j), v(i - 1, j), v(i, j), v(i, j - 1), v(i + 1, j - 1), v(i, j - 1), v(i, j), v(i, j - 1));
            AN(i, j) = main(v(i + 1, j), v(i, j), v(i, j + 1), v(i, j), v(i, j + 1), v(i - 1, j + 1), v(i, j + 1), v(i, j));
            AC(i, j) = - (AW(i, j) + AE(i, j) + AS(i, j) + AN(i, j)) + 1;
        end
    end

    A = A + diag(AC'(:));
    A = A + diag(AN'(:)(2:n), 1);
    A = A + diag(AS'(:)(1:n - 1), -1);
    A = A + diag(AE'(1:m - 1,:)(:), m);
    A = A + diag(AW'(2:m,:)(:), -m);
end
