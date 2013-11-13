% Benjamin Shih
% 16720F13 Computer Vision
% Assignment 5 3D Reconstruction
% Eight Point Algorithm

% Computes the fundamental matrix based on input points from X and Y, with
% scale M.

function [ F ] = eightpoint( X, Y, M )
    scale = [1/M 0 0; 0 1/M 0; 0 0 1];
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
    F = scale'*F*scale;
    
end















% function [ F ] = eightpoint( X, Y, M )
% 
%     im1Pts = [X(:,1) Y(:,1)];
%     im2Pts = [X(:,2) Y(:,2)];
%     
% %     % Scale the data to be between 0 and 1.
% %     xnorm = (im1Pts - min(im1Pts(:))) ./ (max(im1Pts(:) - min(im1Pts(:))));
% %     ynorm = (im2Pts - min(im2Pts(:))) ./ (max(im2Pts(:) - min(im2Pts(:))));
%     
%     % Normalize the data to have centroid at (0,0) and average distance
%     % from origin sqrt(2).
%     x1 = [im1Pts'; ones(1, size(im1Pts,1))];
%     x2 = [im2Pts'; ones(1, size(im2Pts,1))];
% 
%     
%     npts = size(X, 1);
%         % Normalise each set of points so that the origin 
%     % is at centroid and mean distance from origin is sqrt(2). 
%     % normalise2dpts also ensures the scale parameter is 1.
%     [x1, T1] = normalise2dpts(x1);
%     [x2, T2] = normalise2dpts(x2);
%     
%     % Build the constraint matrix
%     A = [x2(1,:)'.*x1(1,:)'   x2(1,:)'.*x1(2,:)'  x2(1,:)' ...
%          x2(2,:)'.*x1(1,:)'   x2(2,:)'.*x1(2,:)'  x2(2,:)' ...
%          x1(1,:)'             x1(2,:)'            ones(npts,1) ];       
% 
% 	[U,D,V] = svd(A,0); % Under MATLAB use the economy decomposition
% 
%     % Extract fundamental matrix from the column of V corresponding to
%     % smallest singular value.
%     F = reshape(V(:,9),3,3)';
%     
%     % Enforce constraint that fundamental matrix has rank 2 by performing
%     % a svd and then reconstructing with the two largest singular values.
%     [U,D,V] = svd(F,0);
%     F = U*diag([D(1,1) D(2,2) 0])*V';
%     
%     % Denormalise
%     F = T2'*F*T1;
    
    %     [xscale, T1] = normalise2dpts(xnorm);
%     [yscale, T2] = normalise2dpts(ynorm);
%     
%     % Nx1 dimensional coordinate points.
%     x = xscale(:,1);
%     xp = xscale(:,2);
%     y = yscale(:,1);
%     yp = yscale(:,2);
%     
%     numPts = size(xp, 1);
%     
%     % Generate the Nx9 constraint matrix A.
%     A = [x.*xp, ...
%          x.*yp, ...
%          x, ...
%          y.*xp, ...
%          y.*yp,  ...
%          y,  ...
%          xp,  ...
%          yp,  ...
%          ones(numPts, 1)];
%     
%     % Compute the SVD of A
%     [U, S, V] = svd(A, 0);
%     F = reshape(V(:,9), 3, 3)';
%     [FU, FS, FV] = svd(F, 0);
%     FS(3,3) = 0;
%     F = FU*FS*FV';
%     F = T2'*F*T1;
    


% function [ F ] = eightpoint( X, Y, M )
%     scale = [1/M 0 0; 0 1/M 0; 0 0 1];
%     xscale = X ./ M;
%     yscale = Y ./ M;
%     
%     % Nx1 dimensional coordinate points.
%     x = xscale(:,1);
%     xp = xscale(:,2);
%     y = yscale(:,1);
%     yp = yscale(:,2);
%     
%     numPts = size(xp, 1);
%     
%     % Generate the Nx9 A matrix.
%     A = [x.*xp, ...
%          x.*yp, ...
%          x, ...
%          y.*xp, ...
%          y.*yp,  ...
%          y,  ...
%          xp,  ...
%          yp,  ...
%          ones(numPts, 1)];
%     
%     % Compute the SVD of A
%     [U, S, V] = svd(A);
%     F = reshape(V(:,9), 3, 3)';
%     [FU, FS, FV] = svd(F);
%     FS(3,3) = 0;
%     F = FU*FS*FV'
%     F = F.*M;
%     
% end


%% Useful for checking if the points are correct:
% close; figure; imshow(im2);hold on; scatter(myBasePts(:,1), myBasePts(:,2))
% close; figure; imshow(im1);hold on; scatter(myInputPts(:,1), myInputPts(:,2))

% F = eightpoint([myBasePts(:,1) myInputPts(:,1)], [myBasePts(:,2) myInputPts(:,2)], 640)
