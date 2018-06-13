function [z, u_denoised] = Denoise()
    % Hyperparameters
    K = 10;
    m = 32;

    [u_exact, z] = set_image(m);
    u0 = ImageRHS(u_exact);
    u = u0;

    for k=1:K
        A = ImageMatrix(u);
        u = A \ u0;
        % u_gs = GS(A, u0, u, 100000, 1e-2);
        % u_jacobi = Jacobi(A, u0, u, 100000, 1e-2);
    end

    u_denoised = reshape(u, [m, m])';
    imshow(u_denoised);
end
