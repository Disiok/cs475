function [A, b] = Lap2D(m)
    h = 1 / (m + 1);
    A = zeros(m ^ 2);
    b = zeros(m ^ 2, 1);

    for i = 1:m
        for j = 1:m
            x_i = i * h;
            y_i = j * h;
            k = reindex(i, j, m);
            if ((norm([x_i, y_i] - [0.3, 0.3]) <= 0.1) || (norm([x_i, y_i] - [0.6, 0.6]) <= 0.1))
                b(k) = 1;
            end

            A(k, reindex(i, j, m)) = 4;
            if (i - 1 >= 1)
                A(k, reindex(i - 1, j, m)) = -1; 
            end
            if (i + 1 <= m)
                A(k, reindex(i + 1, j, m)) = -1; 
            end
            if (j - 1 >= 1)
                A(k, reindex(i, j - 1, m)) = -1; 
            end
            if (j + 1 <= m) 
                A(k, reindex(i, j + 1, m)) = -1; 
            end 
        end
    end
    A = A / (h ^ 2);
end 

function k = reindex(i, j, m)
    k = (j - 1) * m + i;
end 
