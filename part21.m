load lightField.mat
 % change of d in rays2img only change the zoom in/zoom out, but doesn't change the clarity and does not peoduce sharp image
[img, x, y] = rays2img(rays(1,:), rays(3,:), 0.1, 200);
figure;
subplot(3,2,1);
image(x([1 end]),y([1 end]),img); axis image xy;
title("pixel: 200");

[img, x, y] = rays2img(rays(1,:), rays(3,:), 0.1, 50);
subplot(3,2,2);
image(x([1 end]),y([1 end]),img); axis image xy;
title("pixel: 50");

[img, x, y] = rays2img(rays(1,:), rays(3,:), 0.1, 500);
subplot(3,2,3);
image(x([1 end]),y([1 end]),img); axis image xy;
title("pixel: 500");

[img, x, y] = rays2img(rays(1,:), rays(3,:), 0.1, 1000);
subplot(3,2,4);
image(x([1 end]),y([1 end]),img); axis image xy;
title("pixel: 1000");

[img, x, y] = rays2img(rays(1,:), rays(3,:), 0.1, 5000);
subplot(3,2,5);
image(x([1 end]),y([1 end]),img); axis image xy;
title("pixel: 5000");

[img, x, y] = rays2img(rays(1,:), rays(3,:), 0.1, 15000);
subplot(3,2,6);
image(x([1 end]),y([1 end]),img); axis image xy;
title("pixel: 15000");
zoom;

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
[img, x, y]=rays2img(rays_propagated(1,:), rays_propagated(3,:), 0.15, 1000);
figure;
image(x([1 end]),y([1 end]),img); axis image xy;

% still not producing sharp image, because ray's diverging out as they
% travel, not converging to a point. We need a lens
%According to equation 6, x₂ = x₁ + d·θ_x₁， θ_x₂ = θ_x₁ the angle remain
%constant, the free space propagation does not change the direction of the
%ray, since rays are emitted at different angle, they will diverge forever.   
%To make them converge, we need a lens and M_f to bend rays

