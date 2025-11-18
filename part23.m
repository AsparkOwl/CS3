%% Part 2.2.3
load lightField.mat
f=0.15; % focal length of lens I fixed it for now
M_f=[1,0,0,0;
    -1/f,1,0,0;
    0,0,1,0;
    0,0,-1/f,1]; % lens matrix
d2=0.24% d2=0.24 is the best given f=0.15
M_d2 = [1, d2, 0, 0; 0, 1, 0, 0; 0, 0, 1, d2; 0, 0, 0, 1];
rays_out = M_d2 * M_f * rays;
[img, x, y] = rays2img(rays_out(1,:), rays_out(3,:), 0.005, 1000);
img_flipped = flip(flip(img, 1), 2);
figure;
image(x([1 end]), y([1 end]), img_flipped); axis image xy;
title(sprintf('f=%.2f, d2=%.2f', f, d2));

% it's a bruno, a unitree robot and a WashU badge