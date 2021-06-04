% Finds eigenvalues and eigenvectors for Laplace operator on square
% [-1,1] x [-1,1], with zero Dirichlet boundary condition.
% In our case, we are not going to try to fing the eigenvalues and
% eigenvectors for a Laplace operator on a square, but on a rectangular
% surface, so we will have a different domain, could be, for example,
%[-1, 1] x [-1.5,1.5] -> ocd kicking in to keep the ratio, hah.

% Solution is based on spectral collocation method as discussed in Aurentz
% & Trefethen (2017), code inspired by Trefethen (2000). The script uses
% CHEBFUN package. (Path to CHEBFUN package must be in your Matlab path.)

clear all

% Number of Chebyshev collocation points in X and Y direction, ?arbitrary
% choice, could easily be some other rectangle, but we'll stick to this
% ratio in our choice of rectangle dimensions?
NX = 12;
NY = 18;

%--- DIFFERENTIATION MATRICES

Domayn = [-1.5, 1.5];

% Differentiation matrix, second derivative with respect to x
DiffX = diffmat(NX, 2);

% remove the first and the last column and the first and the last row
% I guess you could also just use the function diffmat to place the
% boundary conditions on the matrix and then maybe calculate it from there?
DX = DiffX(2:(NX-1), 2:(NX-1)); 

% Differentiation matrix, second derivative with respect to y
DiffY = diffmat(NY, 2, Domayn);

% remove first and the last column and the first and the last row
DY = DiffY(2:(NY-1), 2:(NY-1));

%--- LAPLACE OPERATOR VIA TENSOR PRODUCT, DIRICHLET BOUNDARY CONDITIONS

% Identity matrices
IdentityX = eye(NX-2);
IdentityY = eye(NY-2);

% Laplace operator, Kronecker product
Laplace = -kron(IdentityX, DY) - kron(DX, IdentityY); 

%--- SOLVE EIGENVALUE PROBLEM

[V, D] = eig(Laplace);

% Order the eigenvalues and eigenvectors
LaplaceEigenvaluesUnsorted = diag(D);
[LaplaceEigenvalues, Permutation] = sort(LaplaceEigenvaluesUnsorted);

LaplaceEigenvectors = V(:, Permutation);

%--- PLOT RESULTS

FineNodes = -1:0.01:1;
FineNodes2 = -1.5:0.01:1.5;
[XGridFine, YGridFine] = meshgrid(FineNodes, FineNodes2);
[XGridCoarse, YGridCoarse] = meshgrid(chebpts(NX), chebpts(NY));

% We are not in a cirque, but I kinda wish we were?
tiledlayout(4,4) 
% tiledlayout requires R2019b or later - oh my, isn't that kinda expected?
colormap gray

% Plot some eigenfunctions

for i = 1:16
    % eigenfunction values including boundary nodes
    % be careful regarding the canonical ordering in meshgrid and the
    % ordering used in our implementation
    EigenvectorToPlot = zeros(NY, NX);
    
    % rewrite inner nodes by calculated values 
    EigenvectorToPlot(2:(NY-1), 2:(NX-1)) = reshape(LaplaceEigenvectors(:, i), NY-2, NX-2);
    
    % normalise the eigenvector such that the supremum norm of the
    % eigenvector is equal to one
    EigenvectorToPlot = EigenvectorToPlot/(norm(EigenvectorToPlot, Inf));
    
    
    % interpolation for 2-D gridded data in meshgrid format
    InterpolantEigenvectorToPlot = interp2(XGridCoarse, YGridCoarse, EigenvectorToPlot, XGridFine, YGridFine, 'spline');
    
    nexttile
    contourf(FineNodes, FineNodes2, InterpolantEigenvectorToPlot, 20, 'k-', 'ShowText', 'off')      
    %title(['Eigenvector #' num2str(i) ', eigenvalue \lambda_{' num2str(i) '} = ' num2str(LaplaceEigenvalues(i)) ])
    
    title(['\lambda_{' num2str(i) '} = ' num2str(LaplaceEigenvalues(i)) ])
        axis square
end

% Print eigenvalues
LaplaceEigenvalues(1:16)