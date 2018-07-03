function [v, beta] = House(x)
    sigma = norm(x(2:end));
    v = vertcat([1], x(2:end));
    if sigma^2 == 0 && x(1) >= 0
        beta = 0;
    else if sigma^2 == 0 && x(1) < 0
        beta = 2;
    else
        if x(1) <= 0
            v(1) = x(1) - sqrt(x(1)^2 + sigma^2);
        else
            v(1) = - sigma^2 / (x(1) + sqrt(x(1)^2 + sigma^2));
        end
        beta = 2 * v(1)^2 / (sigma^2 + v(1)^2);
        v = v / v(1);
    end
end
