%{
Author: Hector Jair Morales Gomez
Date:28/10/22
Lab 2. Snakes Segmentation
%}
%% 1. Cleaning workspace
clear()
%% 2. Reading the image

I = imread('irm_1.jpg');
firstPlane = im2double(I(:,:,1));
imshow(firstPlane);
%% 3. Initialization of the weighting parameters

alpha = 0.1; % elasticity : ?
beta = 0.5; % rigidity : ?
gamma = 10; % viscosity : ?
kappa = 2; % external force weighting parameter ?
kappap = 0.2; % balloon force weighting parameter ?
Niter = 20; % resampling frequency parameter : ?
ITER = 30; % total number of iterations (to optimize) : ?
dmax = 2; % max and min distances for contour resampling : ?
dmin = 0.5;
delta = 0.3; % sampling step

%% 4. Gaussian filtering

gaussFilter = fspecial('gaussian',3,0.3);
gaussFiltered = imfilter(firstPlane, gaussFilter);
subplot(1,2,1), imshow(firstPlane);
subplot(1,2,2), imshow(gaussFiltered);

%% 5. Gradient forces

[px, py] = gradient(gaussFiltered);
normegrad = (sqrt(px.^2+py.^2));
figure();
quiver(px(1:3:end,1:3:end), py(1:3:end,1:3:end));
quiver(px, py);


%% 6. Snake deformation

subplot(1,2,1), imshow(I);
subplot(1,2,2), imshow(gradient(gaussFiltered));

delta = 1;

[x,y] = snakeinit(delta);

alpha = 1.5; 
beta = 0.7;  
gamma = 20; 
kappa = 0.21;
kappap=2.3; %
ITER=20;    %
Niter = 37; %
dmin=0.5;   %
dmax=5;
compteur = 0;

x = [x, x(1)];
y = [y, y(1)];
x = x'
y = y'

for i=1:ITER
    [x,y] = snakedeform(x,y,alpha,beta,gamma,kappa,kappap,px,py,Niter);
    hold on; plot(x,y,'yellow'); hold off;
    pause(0.5)
    [x,y] = snakeinterp(x,y,dmax,dmin);
end



