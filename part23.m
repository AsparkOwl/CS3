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
[img, x, y] = rays2img(rays_out(1,:), rays_out(3,:), 0.003, 1000); % we use 1000 because it feels best from part2.2(1)
img_flipped = flip(flip(img, 1), 2); % flip the upside down image
figure;
image(x([1 end]), y([1 end]), img_flipped); axis image xy; % somehow the image in function is not working, do it here
title(sprintf('f=%.2f, d2=%.2f', f, d2));

% it's a bruno, a unitree robot and a WashU badge
% f = 0.15;

%{
for d2 = 0.15:0.02:0.35
    M_f = [1, 0, 0, 0; -1/f, 1, 0, 0; 0, 0, 1, 0; 0, 0, -1/f, 1];
    M_d2 = [1, d2, 0, 0; 0, 1, 0, 0; 0, 0, 1, d2; 0, 0, 0, 1];
    rays_out = M_d2 * M_f * rays;
    [img, x, y] = rays2img(rays_out(1,:), rays_out(3,:), 0.1, 1000);
    
    figure;
    image(x([1 end]), y([1 end]), img); axis image xy;
    title(sprintf('f=%.2f, d2=%.2f', f, d2));
    pause(0.5);
end
%}

% Mention this is report! Set f to be 0.15 based on part1, scan d2 from 0.1
% to 0.5 with 0.05 seperation, then do another fine scan from 0.15 to 0.35 with 0.02 seperation,
% then another scan from 0.2 to 0.3 with 0.01 seperation, finding 0.24 as
% the best d2 value.

% Since we don't know what d1 is, lens is placed right at z=0 and we hunt
% for f and d2 to make things in focus