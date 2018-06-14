function [z, u_denoised] = BestSOR()
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

        best_elapsed = 1000;
        best_omega = 0;
        for i=1:100
            u_sor = u0;
            iter_sor_sum = 0;
            omega = i;

            % fprintf("Running SOR with omega %d\r\n", omega);
            time = cputime;
            for k=1:K
                A = ImageMatrix(u_sor, alpha);
                [u_sor, iter_sor] = SOR(omega, A, u0, u_sor, maxiter, tol);
                iter_sor_sum = iter_sor_sum + iter_sor;
            end
            elapsed = cputime - time;
            if (elapsed < best_elapsed)
                best_omega = omega;
                best_elapsed = elapsed;
            end
            % fprintf("SOR with omega %d finished in %d iters, %d seconds\r\n", omega, iter_sor_sum, elapsed);
        end
        fprintf("Best omega is %d\r\n", best_omega);
    end
end
