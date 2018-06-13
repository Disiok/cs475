function [z, u_denoised] = Denoise()
    % Hyperparameters
    K = 10;
    m = 16;

    [u_exact, z] = set_image(m);
    u0 = ImageRHS(z);
    u = u0;

    for k=1:K
        A = ImageMatrix(u);
        u = A \ u0;
    end

    u_denoised = reshape(u, [m, m])';
    imshow(u_denoised);
end
