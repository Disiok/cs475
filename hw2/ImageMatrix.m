function A = ImageMatrix(u_vec)
    % Hyper parameters
    alpha = 4 * 10 ^ (-2);
    beta = 10 ^ (-6);


    % Input
    n = size(u_vec, 1);
    m = sqrt(n);
    u = reshape(u_vec, [m, m])';
    h = 1 / (m + 1);

    % Setup
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

    AC_vec = AC'(:);
    AN_vec = AN'(:)(2:n);
    AS_vec = AS'(:)(1:n - 1);
    AE_vec = AE(1:m - 1,:)'(:);
    AW_vec = AW(2:m,:)'(:);

    A = diag(AC_vec) + diag(AN_vec, 1) + diag(AS_vec, -1) + diag(AE_vec, m) + diag(AW_vec, -m);
    A = sparse(A);
end
