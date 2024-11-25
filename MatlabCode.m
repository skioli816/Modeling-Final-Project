% Set Parameters 
g = 9.81 ; % gravity (m/s^2) 
S = 0.1 ; % bed slope (m/m) 
Cf = 10 ; % drag coefficient 
k = 1.5 ; 
u = 0.536; % horizontal velocity (m/s) 
beta = sqrt(g*S/Cf) ; % (m^1/2 / s) 

% Time Steps 
t0 = 0 ; % initial time (s)
dt = 3600 ; % time step (s) 
tf = 1.21e6 ; % total time (s) 
n = tf/dt ; % number of time steps 
t = nan.*ones(1, tf) 
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
h = ; % lahar thickness (m) 
v = beta*sqrt(h) ; % vertical velocity (m/s)
q = v*h ; % volumetric flow rate (m^3 / s) 


% Primary Equation 
% (dh/dt) + beta*k*(h^(k-1))*(dh/dx) = 0 ; 

% Preallocate 
Aarray = nan.*ones(n, m) ; 
Aarray(1:n, 1) = (((2e3) / dx) - 1)*s ; 
A = Aarray(:, 1) ; 

% Evolution Matrix 
data = [C*ones(n), (1-C)*ones(n)] ; 
diags = [-1, 0] ; 
M = spdiags(data, diags, n, m) ; 

% Set Boundary Conditions 
M(1, 1) = s ; 
M(2e3, 1000) = s ; 

% Model Loop 
for i = 1:m   
    Anew = (A).* M ; 
    Aarray(:, 1000) = Anew(:, 212) ; 
    A = Anew ; 
end 

% FYI I had no idea how to do the Neuman boundary conditions so that part I totally was winging it 
