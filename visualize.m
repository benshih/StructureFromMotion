% Benjamin Shih
% 16720F13 Computer Vision
% Assignment 5 3D Reconstruction
% Q2.1 Metric Reconstruction

% Provided functions:
% camera2.m - Recover M2, the second camera matrix. We assume that M1, the
% first camera matrix, is fixed at [R|t] = [I|0]. Both M1 and M2 are 3x4
% matrices representing the rotation and translation transforms. M1 and M2
% are related by a projective transform and represent the two views used to
% generate F. 

% triangulate.m - Triangulates a set of 2D coordinates in the image to a
% set of 3D points. 

% Using the above two functions, we can determine the 3D location of these
% point correspondences and plot their 3D point locations. The resulting
% figure can be manipulated using the 3D rotate tool found in the figure
% menubar. 

close all

load('temple/intrinsics.mat');
load('temple/some_corresp.mat');
load('many_corresp.mat');
im1 = imread('temple/im1.png');
im2 = imread('temple/im2.png');

M = max(size(im1));
F = eightpoint(pts1, pts2, M);

M1 = [1 0 0 0; 0 1 0 0; 0 0 1 0];
M2 = camera2(F, K1, K2, pts1, pts2);

P = triangulate(K1*M1, [x1 y1], K2*M2, [x2 y2]);
scatter3(P(:,1), P(:,2), P(:,3))


