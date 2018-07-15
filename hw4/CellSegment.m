%
% CS475/675: Assignment 3
%
%   Cell image segmentation
%


%
% Read in cell image
%
U = imread('cellimage.tif');
U = U(365:465,170:270);
U = double(U);
U = U/max(U(:));


%
% Create normalized graph Laplacian from image U
%
NL = CreateImageGraph(U);

Note: 1) use sigma^2 = 0.003 for the intensity weight
         and sigma^2 = 100 for the distance weight

      2) use 8 neighbours for W


%
% Spectral clustering
%

*** Provide your code here! ***



%
% Extract segments for the cell region
%
Clusters = reshape(index,size(U,1),size(U,2));

Disk = fspecial('disk',floor(size(U,1)/2));
Disk = Disk>0;

Cell = zeros(size(U));
for k=1:K
    seg_size = nnz(Clusters==k);
    overlap = (Clusters==(Disk*k));
    in_size = nnz(overlap);
    if in_size == seg_size,
        Cell = Cell + (Clusters==k);
    end
end
Cell = 2*(Cell-0.5);


%
% Visualize segmentation results
%
figure(1);
subplot(1,3,1);
imshow(U,[]);
subplot(1,3,2);
imshow(Clusters,[]);
subplot(1,3,3);
imshow(U,[]);
hold on;
contour(Cell,[0 0],'r', 'linewidth', 1.5);
hold off;
