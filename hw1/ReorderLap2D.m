function [A, b] = ReorderLap2D(m, ordering_method)
    [A, b] = Lap2D(m);
    B = sparse(A);

    switch ordering_method
        case 'natural'
            disp('Using natural order');
        case 'rcm'
            disp('Using rcm order');
            p = symrcm(B);
            A = A(p, p);
            b = b(p);
        case 'min'
            disp('Using min order');
            p = symamd(B);
            A = A(p, p);
            b = b(p);
        otherwise
    end
end
