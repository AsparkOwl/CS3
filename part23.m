%% Part 2.2.3
load lightField.mat
f=0.15; % tuned f
d2=0.24; % tuned d2, would be explained in report
r_lens=0.025;  % Lens radius

theta_x=rays(2,:); % the three objects has different input angles, we sort the angle and devide them into 3
theta_x_sorted=sort(theta_x);
thresh1=theta_x_sorted(round(end/3)); % 1/3 thrshold
thresh2=theta_x_sorted(round(2*end/3)); % 2/3 threshold
M_f=[1,0,0,0;
    -1/f,1,0,0;
    0,0,1,0;
    0,0,-1/f,1]; % lens matrix
M_d2=[1,d2,0,0;
    0,1,0,0;
    0,0,1,d2;
    0,0,0,1];  % from equation 6

rays_set1 = rays(:,theta_x <= thresh1); % Three subsets based on angle threshold
rays_set2 = rays(:,theta_x > thresh1 & theta_x <= thresh2);
rays_set3 = rays(:,theta_x > thresh2);
ray_all={rays_set1,rays_set2,rays_set3}; % group them together for for loop

for i=1:3 % produce 3 images
    rays_subset=ray_all{i}; % get subset
    rays_out = M_d2 * M_f * rays_subset; % compute rays out 
    [img, x, y] = rays2img(rays_out(1,:), rays_out(3,:), 0.003, 400);
    figure;
    img_flipped= flip(flip(img,1),2); % flip the upside down image
    image(x([1 end]),y([1 end]), img_flipped); axis image xy;
    colormap gray; % set colormap to gray
    title(sprintf('Angle subset %d', i));
    fontsize(16,"points");
end

% it's a bruno, a unitree Go2 and a WashU badge
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