% Benjamin Shih
% 16720F13 Computer Vision
% Assignment 5 3D Reconstruction
% Q1.2 Seven Point Algorithm

% Computes the fundamental matrix based on input points from X and Y, with
% scale M using only seven degrees of freedom rather than 8+ by exploiting
% solving a polynomial equation using seven point correspondences. 

function [ F ] = sevenpoint_norm( X, Y, M )
    scale = [1/M 0 0; 0 1/M 0; 0 0 1];
    xscale = X ./ M;
    yscale = Y ./ M;
    
    % Nx1 dimensional coordinate points.
    x = xscale(:,1);
    y = xscale(:,2);
    xp = yscale(:,1);
    yp = yscale(:,2);
    
    numPts = size(xp, 1);
    
    % Generate the Nx9 constraint matrix A.
    A = [x.*xp, ...
         x.*yp, ...
         x, ...
         y.*xp, ...
         y.*yp,  ...
         y,  ...
         xp,  ...
         yp,  ...
         ones(numPts, 1)];
    
    % Compute the SVD of A.
    [U, S, V] = svd(A);
    F1 = reshape(V(:,9), 3, 3);
    F2 = reshape(V(:,8), 3, 3);
    
    syms a;
    S = solve(0 == det(a*F1+(1-a)*F2), a);
    Sreal = real(double(S)); % could also use 'vpa' (variable precision arithmetic)
    
    F = cell(1,3);
    
    for iCell = 1:length(F)
        F{iCell} = Sreal(iCell)*F1 + (1-Sreal(iCell))*F2; 
        F{iCell} = scale'*F{iCell}*scale;
    end

end


% F = eightpoint([myBasePts(:,1) myInputPts(:,1)], [myBasePts(:,2) myInputPts(:,2)], 640)
