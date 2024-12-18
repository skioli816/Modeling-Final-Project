% Video Link: https://youtu.be/OGF3KV5deGA 
% Link to Paper: https://docs.google.com/document/d/1wQVWXo_nl83C7LFNDUNKt2my7z1piMQpm6c6GcvmDr8/edit?tab=t.0 

%% FINAL PROJECT CODE 
% By Aya Kanawati and Sarah Scioli 

close all 

% Set Parameters 
g = 9.81 ; % gravity (m/s^2) 
S = 0.1 ; % bed slope (m/m) 
Cf = 10 ; % drag coefficient 
k = 1.5 ; % value taken from paper 
beta = sqrt(g*S/Cf) ; % (m^1/2 / s) 
h0 = 10 ; % initial lahar thickness (m) 

% Space Steps 
x0 = 0 ; % initial space (m) 
dx = 1 ; % space step (m) 
L = 5000 ; % length of domain (m) 
n = L/dx ; % number of space steps 
x = nan.*ones(1, L) ; 
x(1) = x0 ; 
for i = 1:n 
    x(i+1) = x0 + i*dx ; 
end    

% Time Steps 
t0 = 0 ; % initial time (hr)
dt = 1 ; % time step (hr) 
tf = 336 ; % total time (hr) 
m = tf/dt ; % number of time steps 
t = nan.*ones(1, tf) ; 
t(1) = t0 ; 
for j = 1:m 
    t(j) = t0 + m*dt ; 
end 

% Space Relative to Time 
% Courant number varies in time so is useless outside of loop 
% C = (u*dt) / dx ; % Courant Number (Fraction of space step that a signal has traveled during a time step) 

% Preallocate 
h = NaN(m, 1) ; 
u = NaN(m, 1) ; 
h(:, 1) = h0 ; % initial h condition 
u(:, 1) = beta*k*((h(1, 1))^(k-1)) ; % initial velocity condition 
% M = NaN(m, m) ; 
hall = NaN(m, m) ; 
hall(:, 1) = h ; 

% Primary Equations 
% (dh/dt) + beta*k*(h^(k-1))*(dh/dx) = 0 ; 
% (dh/dt) + (d/dx)*(u*h) = 0 ;
% u = beta*k*(h^(k-1)) ; % horizontal velocity (m/s) 
% Marching Equation = h(i, j+1) = h(i, j) - (dt/dx)*((h(i, j)*u(i, j)) - (h(i-1, j)*u(i-1, j) ; 

% For Loop (FE Method) 
for l = 2:m 
    u(l) = beta*k*((hall(1, l-1))^(k-1)) ; % calculate new velocity 
    M = spdiags([(dt/dx)*(u(l - 1, 1)), abs((1 - ((dt/dx)*(u(l, 1)))))], -1:0, m, m) ; % establish the diagonals
    hnew = M*h ; % calculate new h values 
    hall(:, l) = hnew ; % save h values in matrix 
    h = hnew ; % save new h value for next loop 
end 

% Plot 
figure 
plot(hall) 
title('Lahar Open Channel Flow (Line Plot)') 
ylabel('Lahar Thickness (m)') 
xlabel('Distance (m)')

figure 
plot(hall)
title('Lahar Open Channel Flow (Focused Line Plot)') 
ylabel('Lahar Thickness (m)') 
xlabel('Distance (m)')
xlim([0, 20]) 

figure 
histogram(hall) 
title('Lahar Open Channel Flow (Histogram)') 
ylabel('Lahar Thickness (m)') 
xlabel('Distance (m)')


% See file "Animation Code" for animated figure derived from this code 
% MatlabLive version available for download in the LiveFile file, but GitHub would not allow a Matlab Live file to be viewed online
