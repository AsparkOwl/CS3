%% Part 2.2.3
load lightField.mat
f=0.2; % tuned f
d2=0.4; % tuned d2, would be explained in report
r_lens=0.025;  % Lens radius

lens_positions=[
    0,0;           % Lens centered
    -0.05,0;      % Shifted left 
    0.05,0;       % Shifted right
];

M_f=[1,0,0,0;
    -1/f,1,0,0;
    0,0,1,0;
    0,0,-1/f,1]; % lens matrix
M_d2=[1,d2,0,0;
    0,1,0,0;
    0,0,1,d2;
    0,0,0,1];  % from equation 6

for i=1:size(lens_positions,1)
    x_lens=lens_positions(i,1);
    y_lens=lens_positions(i,2);
    
    hit_lens=abs(rays(1,:)-x_lens)<= r_lens; % Check which rays hit the lens (relative to lens center)
    num_rays=sum(hit_lens); % the number of rays hitting the lens. Idealy it should be 1000000, it is used to tune the shifting value 0.05 above
    rays_subset=rays(:,hit_lens); % Only process rays that hit the lens
    
    % Apply optical system
    rays_out=M_d2 * M_f * rays_subset;
    [img,x,y]=rays2img(rays_out(1,:), rays_out(3,:),0.005,500);   
    figure;
    img_flipped= flip(flip(img,1),2); % flip the upside down image
    image(x([1 end]),y([1 end]), img_flipped); axis image xy;
    colormap gray; % set colormap to gray
    title(sprintf('Lens at (%.4f, %.4f), radius=%.4f, rays hitting= %d',x_lens,y_lens,r_lens,num_rays));
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