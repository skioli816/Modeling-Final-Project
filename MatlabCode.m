%% FINAL PROJECT CODE 
% By Aya Kanawati and Sarah Scioli 

% Set Parameters 
g = 9.81 ; % gravity (m/s^2) 
S = 0.1 ; % bed slope (m/m) 
Cf = 10 ; % drag coefficient 
k = 1.5 ; 
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
t0 = 0 ; % initial time (s)
dt = 1 ; % time step (s) 
tf = 336 ; % total time (s) 
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
h(:, 1) = h0 ; 
u(:, 1) = beta*k*(h(1)^(k-1)) ; 
M = NaN(m, m) ; 

% Primary Equations 
% (dh/dt) + beta*k*(h^(k-1))*(dh/dx) = 0 ; 
% (dh/dt) + (d/dx)*(u*h) = 0 ;
% u = beta*k*(h^(k-1)) ; % horizontal velocity (m/s) 
% Marching Equation = h(i, j+1) = h(i, j) - (dt/dx)*((h(i, j)*u(i, j)) - (h(i-1, j)*u(i-1, j) ; 


% For Loop (FE Method) 
for l = 2:m 
    u(l) = beta*k*(h(l)^(k-1)) ; 
    % h(i, j+1) = h(i, j) - (dt/dx)*((h(i, j)*u(i, j)) - (h(i-1, j)*u(i-1, j)
    M = diag(1 - (dt/dx)*u(l), 0) ; 
    M = diag((dt/dx)*u(l - 1), -1) ; 
    hnew = M.*h ; 
    hall(:, l+1) = hnew ; 
    h = hnew ; 
end 










