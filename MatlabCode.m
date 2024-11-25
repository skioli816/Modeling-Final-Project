% Set Parameters 
g = 9.81 ; % gravity (m/s^2) 
S = 1e-5; % bed slope (m/m) 
Cf = 1 ; % drag coefficient 
k = 1.5 ; 
u = 0.536; % horizontal velocity (m/s) 
beta = sqrt(g*S/Cf) ; % (m^1/2 / s) 

% Define Variables 
h = ; % lahar thickness (m) 
v = beta*sqrt(h) ; % vertical velocity (m/s)
q = v*h ; % volumetric flow rate (m^3 / s) 

% Time Steps 
t0 = 0 ; % initial time (s)
tf = ; % total time (s) 
dt = ; % time step (s) 
n = 1:(tf) ; % number of time steps 
tn = t0 + n*dt ; 

% Space Steps 
x0 = 0 ; % initial space (m) 
dx = ; % space step (m) 
L = ; % length of domain (m) 
i = 1:(L/dx) ; % number of space steps 
xi = x0 + i*dx ; 

% Space Relative to Time 
C = (u*dt) / dx ; % Courant Number (Fraction of space step that a signal has traveled during a time step) 

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
