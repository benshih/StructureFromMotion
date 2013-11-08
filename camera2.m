function [M2] = camera2(F, K1, K2, pts1, pts2)
E = K2' * F * K1;

[U,S,V] = svd(E);
m = (S(1,1)+S(2,2))/2;
E = U*[m,0,0;0,m,0;0,0,0]*V';
[U,S,V] = svd(E);
W = [0,-1,0;1,0,0;0,0,1];

% Make sure we return rotation matrices with det(R) == 1
if (det(U*W*V')<0)
    W = -W;
end

M2s = zeros(3,4,4);
M2s(:,:,1) = [U*W*V',U(:,3)./max(abs(U(:,3)))];
M2s(:,:,2) = [U*W*V',-U(:,3)./max(abs(U(:,3)))];
M2s(:,:,3) = [U*W'*V',U(:,3)./max(abs(U(:,3)))];
M2s(:,:,4) = [U*W'*V',-U(:,3)./max(abs(U(:,3)))];

M1 = eye(3, 4);

for i=1:4
    P = triangulate(K1*M1, pts1, K2*M2s(:,:,i), pts2);
    if all(P(:,3) > 0)
        sprintf('Correct M2: %d\n', i)
        P 
        %K2*M2s(:,:,i)
        M2 = M2s(:,:,i);
    end
end

end
