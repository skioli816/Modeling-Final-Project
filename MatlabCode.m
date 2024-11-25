%% ROUGH DRAFT OF OUR CODE 

% Set Parameters 
g = 9.81 ; % gravity (m/s^2) 
S = 0.1 ; % bed slope (m/m) 
Cf = 10 ; % drag coefficient 
k = 1.5 ; 
u = 0.536; % horizontal velocity (m/s) 
beta = sqrt(g*S/Cf) ; % (m^1/2 / s) 

% Time Steps 
t0 = 0 ; % initial time (s)
dt = 1 ; % time step (s) 
tf = 336 ; % total time (s) 
n = tf/dt ; % number of time steps 
t = nan.*ones(1, tf) ; 
t(1) = t0 ; 
for j = 1:n 
    t(j) = t0 + n*dt ; 
end 

% Space Steps 
x0 = 0 ; % initial space (m) 
dx = 1 ; % space step (m) 
L = 5000 ; % length of domain (m) 
m = L/dx ; % number of space steps 
x = nan.*ones(1, L) ; 
x(1) = x0 ; 
for i = 1:m 
    x(i+1) = x0 + i*dx ; 
end    

% Space Relative to Time 
C = (u*dt) / dx ; % Courant Number (Fraction of space step that a signal has traveled during a time step) 

% Define Variables 
h0 = 10 ; 
h = zeros(m, length(t)) ; % lahar thickness (m) 
for j = 1:n 
    for i = 1:m
        h(j, i) = h0*sin(10*3.1415*(x(i) - t(j))) ;  
    end 
end 
v = beta*sqrt(h) ; % vertical velocity (m/s)
q = v*h ; % volumetric flow rate (m^3 / s) 

% Primary Equation 
% (dh/dt) + beta*k*(h^(k-1))*(dh/dx) = 0 ; 

% Preallocate 
Aarray = nan.*ones(m, n) ; 
Aarray(1:m, 1) = (((5000) / dx) - 1)*beta ; 
A = Aarray(:, 1) ; 

% Evolution Matrix 
data = [C*ones(m), (1-C)*ones(m)] ; 
diags = [-1, 0] ; 
M = spdiags(data, diags, m, n) ; 

% Set Boundary Conditions 
M(1, 1) = beta ; 
M(5000, 363) = beta ; 

% Model Loop 
for i = 1:n   
    Anew = (A).* M ; 
    Aarray(:, 363) = Anew(:, i) ; 
    A = Anew ; 
end 
