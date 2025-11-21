load lightField.mat
pixel_set={50,200,1000,10000};
 % change of d in rays2img only change the zoom in/zoom out, but doesn't change the clarity and does not peoduce sharp image
for i=1:length(pixel_set)
    pixel = pixel_set{i}; % Get the current d value from the set
    [img, x, y] = rays2img(rays(1,:), rays(3,:), 0.01, pixel); 
    if mod(i,2)==1 % create two plots for the sake of clarity
        figure;
        subplot(1,2,1);
    else
        subplot(1,2,2);
    end
    image(x([1 end]),y([1 end]),img); axis image xy;
    title(sprintf("pixel: %d",pixel));
    colormap gray;
    fontsize(16,"points"); % fix all fontsize
end

% above is trying on different pixel values. Picture becomes somehow
% visible ar 500 and 1000 and becomes too fine at 5000 and 15000. However,
% it still does not produce a sharp image
%% Part 2.1（d）
d=0.00001; %ray travelling distance
M_d=[1,d,0,0;
    0,1,0,0;
    0,0,1,d;
    0,0,0,1];  % from equation 6
rays_propagated = M_d * rays; % equation 7
[img, x, y]=rays2img(rays_propagated(1,:), rays_propagated(3,:), 0.01, 500);
figure;
image(x([1 end]),y([1 end]),img); axis image xy;
colormap gray;
title(sprintf("rays with propagating distance d= %d",d));
fontsize(16,"points");

%Part 2.2:
% still not producing sharp image, because ray's diverging out as they
% travel, not converging to a point. We need a lens
%According to equation 6, x₂ = x₁ + d·θ_x₁， θ_x₂ = θ_x₁ the angle remain
%constant, the free space propagation does not change the direction of the
%ray, since rays are emitted at different angle, they will diverge forever.   
%To make them converge, we need a lens and M_f to bend rays

% Can include multiple figures in report here

