function GETimes
    for i = 1:4
        m = i * 10;
        [A, b] = Lap2D(m);
        fprintf('----------\n');
        fprintf('Grid size: ');
        disp(m);
        
        start_time = cputime;

        x_ge = GaussElim(A, b);
        ge_time = cputime;
        ge_elapsed = ge_time - start_time;
        fprintf('GaussElim: ');
        disp(ge_elapsed);

        x_cho = Cholesky(A, b);
        cho_time = cputime;
        cho_elapsed = cho_time - ge_time;
        fprintf('Cholesky: ');
        disp(cho_elapsed);

        x_bge = BandGE(A, b); 
        bge_time = cputime;
        bge_elpsed = bge_time - cho_time;
        fprintf('BandGE: ');
        disp(bge_elpsed);
end
