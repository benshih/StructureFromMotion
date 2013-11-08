% Benjamin Shih
% 16720F13 Computer Vision
% Assignment 5 3D Reconstruction
% Eight Point Algorithm

% Computes the fundamental matrix based on input points from X and Y, with
% scale M.

function [ F ] = eightpoint( X, Y, M )
    xscale = X ./ M;
    yscale = Y ./ M;
    
    % Nx1 dimensional coordinate points.
    x = xscale(:,1);
    xp = xscale(:,2);
    y = yscale(:,1);
    yp = yscale(:,2);
    
    numPts = size(xp, 1);
    
    % Generate the Nx9 A matrix.
    A = [x.*xp, ...
         x.*yp, ...
         x, ...
         y.*xp, ...
         y.*yp,  ...
         y,  ...
         xp,  ...
         yp,  ...
         ones(numPts, 1)];
    
    % Compute the SVD of A
    [U, S, V] = svd(A);
    F = reshape(V(:,9), 3, 3)';
    [FU, FS, FV] = svd(F);
    FS(3,3) = 0;
    F = FU*FS*FV';
    
end


%% Useful for checking if the points are correct:
% close; figure; imshow(im2);hold on; scatter(myBasePts(:,1), myBasePts(:,2))
% close; figure; imshow(im1);hold on; scatter(myInputPts(:,1), myInputPts(:,2))