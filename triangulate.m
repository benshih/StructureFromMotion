function [P] = triangulate( M1, p1, M2, p2 )
% Triangulate a set of points given camera matrices
% M1
% M2  -- Camera matrices 3x4
% p1
% p2  -- Point sets, N x 2
% P   -- 3D points, N x 3

% Make homogeneous
p1 = [ p1'; ones(1, size(p1, 1))];
p2 = [ p2'; ones(1, size(p2, 1))];

sz = size(p1, 2);

for i = 1:sz
    T = [ contreps(p1(:,i))*M1 ; ...
        contreps(p2(:,i))*M2 ];

    [ U, S, V ] = svd(T);
    pt = V(:, end);
    P(:,i) = pt/pt(4);
end

P = P';
P(:,4) = [];

return;
%-------


function Y = contreps(X)

if prod(size(X)) == 3  % get [X]_\times
  Y = [0 X(3) -X(2)
      -X(3) 0 X(1)
       X(2) -X(1) 0];
elseif all(size(X) == [1 2])
  Y = [0 1; -1 0]*X';
elseif all(size(X) == [2 1])
  Y = X'*[0 1; -1 0];
elseif all(size(X) == [3 3]) % get X from [X]_\times
  Y = [X(2,3) X(3,1) X(1,2)];
elseif all(size(X) == [4 4])  % pluecker matrix dual
  Y = [0      X(3,4) X(4,2) X(2,3) 
       X(4,3) 0      X(1,4) X(3,1)
       X(2,4) X(4,1) 0      X(1,2)
       X(3,2) X(1,3) X(2,1) 0     ];
else
  error('Wrong matrix size.')
end
