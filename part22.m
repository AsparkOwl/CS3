%% Part 2.2
load lightField.mat
d1=0.01;
M_d=[1,d1,0,0;
    0,1,0,0;
    0,0,1,d1;
    0,0,0,1];  % from equation 6

rays_out=M_d*rays_in; % equation 7
f=0.15; % focal length of lens
M_f=[1,0,0,0;
    -1/f,1,0,0;
    0,0,1,0;
    0,0,-1/f,1]; % lens matrix
d2=(1/f-1/d)^-1; % from equation 11, this ends at the focusing point
M_d2=[1,d2,0,0;
    0,1,0,0;
    0,0,1,d2;
    0,0,0,1];  % from equation 6
rays_out_2=M_d2*M_f*M_d*rays_in; % equation 13