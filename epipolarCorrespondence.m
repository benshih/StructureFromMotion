% Benjamin Shih
% 16720F13 Computer Vision
% Assignment 5 3D Reconstruction
% Q3.1 3D Visualization

% This function creates a 3D rendering of the courtyard by treating he two
% images as a stereo-pair. This assumption allows us to triangulate
% corresponding points in each image, and render their 3D location. 

function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
    im1pt = [x1; y1; 1];
    epipolarLine = F*im1pt;
    scale = sqrt(epipolarLine(1)^2+epipolarLine(2)^2);
    epipolarLine = epipolarLine/scale;
    
    % Create w x h (?) window with the input point as the top left corner
    % for comparison. Currently does not do error checking for going out of
    % the image bounds.
    h = 32;
    w = h;
    [m, n, ~] = size(im1);
    windowRange = 1:m-h;
    im1window = im1(y1:(y1+w-1), x1:(x1+h-1));
    
    % Determine the point in each row of the image that belongs to the
    % line.
    epipolarPoints = zeros(length(windowRange), 2);
    epipolarPtDiff = zeros(length(windowRange), 1);
    for iRow = windowRange
        col = (-epipolarLine(2)*iRow - epipolarLine(3))/epipolarLine(1);
        epipolarPoint = [col; iRow; 1];
        epipolarPoints(iRow, :) = [epipolarPoint(1) epipolarPoint(2)];
        im2window = im2(iRow:(iRow+h-1), col:(col+w-1));
        epipolarPtDiff(iRow) = norm(fspecial('gaussian', [h w]) .* (double(im1window) - double(im2window)));
    end
    
    % Find the point corresponding to the minimum.
    [val, indx] = min(epipolarPtDiff);
    x2 = epipolarPoints(indx, 1);
    y2 = epipolarPoints(indx, 2);
end
