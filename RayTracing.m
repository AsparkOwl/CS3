d=0.2; % total simulation distance
N_rays=8; % 8 rays per x
theta_x=linspace(-pi/20, pi/20,N_rays); % 8 values from -pi/20, pi/20

Ray_Blue=[zeros(1,N_rays);
           theta_x;
           zeros(1,N_rays);
           zeros(1,N_rays)]; % ray starting at x=0

Ray_Red=[repmat(0.01,1,N_rays);
           theta_x;
           zeros(1,N_rays);
           zeros(1,N_rays)]; % ray starting at x=0.01

rays_in=[Ray_Blue,Ray_Red]; % put them together for 4*16 matrix

M_d=[1,d,0,0;
    0,1,0,0;
    0,0,1,d;
    0,0,0,1];  % from equation 6

rays_out=M_d*rays_in; % equation 7

ray_z = [zeros(1,size(rays_in,2)); d*ones(1,size(rays_in,2))];  % below is matrix plotting
plot(ray_z(:,1:8), [rays_in(1,1:8); rays_out(1,1:8)], 'b');
hold on;
plot(ray_z(:,9:16), [rays_in(1,9:16); rays_out(1,9:16)], 'r');
xlabel("z(m)")
ylabel("x(m)");
title("Ray Propagation in Medium");

f=0.15; % focal length of lens
r_lens=0.02; %radius of lens is 0.02m
M_f=[1,0,0,0;
    -1/f,1,0,0;
    0,0,1,0;
    0,0,-1/f,1];
d2=(1/f-1/d)^-1; % from equation 11, this ends at the focusing point
M_d2=[1,d2,0,0;
    0,1,0,0;
    0,0,1,d2;
    0,0,0,1];  % from equation 6
rays_out_2=M_d2*M_f*M_d*rays_in; % equation 13

figure;
ray_z1=[zeros(1,16);d*ones(1,16)]; % plot from 0 to 0.2 first
hit_lens=(abs(rays_out(3,:))<=r_lens) & (abs(rays_out(1,:))<=r_lens);% find lens that hit the lens
hit_blue=find(hit_lens(1:8)); % blue rays index
hit_red=find(hit_lens(9:16))+8; % red rays index, index is 9-18 but

hold on; 
plot(ray_z1(:,1:8), [rays_in(1,1:8); rays_out(1,1:8)], 'b','LineWidth',1.5);% plot blue before lens
plot(ray_z1(:,9:16), [rays_in(1,9:16); rays_out(1,9:16)], 'r','LineWidth',1.5);% plot red before lens

plot([d,d],[-r_lens,r_lens], 'k','LineWidth',3); % plot the lens

ray_z2 = [d*ones(1,16); (d+d2)*ones(1,16)]; % plot from 0.2 to 0.2+d2
plot(ray_z2(:,hit_blue), [rays_out(1,hit_blue); rays_out_2(1,hit_blue)], 'b','LineWidth',1.5); % plot blue after lens, only keeping the hit ray
plot(ray_z2(:,hit_red), [rays_out(1,hit_red); rays_out_2(1,hit_red)], 'r','LineWidth',1.5); % same with above, only keep hit ray
xlabel('z (m)'); ylabel('x (m)');
title("Ray Propagation in Medium");