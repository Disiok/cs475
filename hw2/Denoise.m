function [z, u_denoised] = Denoise()
    % Hyperparameters
    K = 10;
    tol = 1e-2;
    maxiter = 100000;

    m_grid = [16, 32, 64, 128];
    alpha_grid = [4e-2, 3e-2, 1.5e-2, 1.2e-2];

    for i=1:4
        m = m_grid(i);
        alpha = alpha_grid(i);
        fprintf("Running %dx%d grid: \n", m, m);
        fprintf("Using alpha: %e\r\n", alpha);

        [u_exact, z] = set_image(m);
        u0 = ImageRHS(z);
        u = u0;

        u_gs = u0;
        u_jacobi = u0;
        u_sor = u0;
        u_cg = u0;

        iter_gs_sum = 0;
        iter_jacobi_sum = 0;
        iter_sor_sum = 0;
        iter_cg_sum = 0;

        fprintf("Running A\\u0\r\n");
        for k=1:K
            A = ImageMatrix(u, alpha);
            u = A \ u0;
        end

        fprintf("Running GS\r\n");
        time = cputime;
        for k=1:K
            A = ImageMatrix(u_gs, alpha);
            [u_gs, iter_gs] = GS(A, u0, u_gs, maxiter, tol);
            iter_gs_sum = iter_gs_sum + iter_gs;
        end
        elapsed = cputime - time;
        fprintf("GS finished in %d iters, %d seconds\r\n", iter_gs_sum, elapsed);

        fprintf("Running Jacobi\r\n");
        time = cputime;
        for k=1:K
            A = ImageMatrix(u_jacobi, alpha);
            [u_jacobi, iter_jacobi] = Jacobi(A, u0, u_jacobi, maxiter, tol);
            iter_jacobi_sum = iter_jacobi_sum + iter_jacobi;
        end
        elapsed = cputime - time;
        fprintf("Jacobi finished in %d iters, %d seconds\r\n", iter_jacobi_sum, elapsed);

        fprintf("Running SOR\r\n");
        time = cputime;
        for k=1:K
            A = ImageMatrix(u_sor, alpha);
            [u_sor, iter_sor] = SOR(0.5, A, u0, u_sor, maxiter, tol);
            iter_sor_sum = iter_sor_sum + iter_sor;
        end
        elapsed = cputime - time;
        fprintf("SOR finished in %d iters, %d seconds\r\n", iter_sor_sum, elapsed);

        fprintf("Running CG\r\n");
        time = cputime;
        for k=1:K
            A = ImageMatrix(u_cg, alpha);
            [u_cg, iter_cg] = CG(A, u0, u_cg, maxiter, tol);
            iter_cg_sum = iter_cg_sum + iter_cg;
        end
        elapsed = cputime - time;
        fprintf("CG finished in %d iters, %d seconds\r\n", iter_cg_sum, elapsed);

        % u_denoised = reshape(u, [m, m])';
        % imshow(u_denoised);
    end
end
