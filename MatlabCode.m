% Sarah's PS5 Code that doesn't bug but is also definitely wrong (Part (a)) 
% Set Parameters 
u = 1 ; % m/s 
x = [0:1:2e3] ; % km 
t = [0: 1: 1000] ; % yrs 
dt = 1 ; % (yr) Chosen so that C will equal one and the solution will be accurate & stable 
dx = 1 ; % (km) Chosen so that C will equal one and the solution will be accurate & stable
C = u*(dt/dx) ; 
n = 2000 ; 
m = t(1001) / dt ; 
s = exp(((0.0001*0) - 30)*20) ; 

% Preallocate 
Jarray = nan.*ones(n, m) ; 
Jarray(1:n, 1) = (((2e3) / dx) - 1)*s ; 
J = Jarray(:, 1) ; 

% Evolution Matrix 
data = [C*ones(n), (1-C)*ones(n)] ; 
diags = [-1, 0] ; 
M = spdiags(data, diags, n, m) ; 

% Set Boundary Conditions 
M(1, 1) = s ; 
M(2e3, 1000) = s ; 

% Model Loop 
for i = 1:m   
    Jnew = (J).* M ; 
    Jarray(:, 1000) = Jnew(:, 212) ; 
    J = Jnew ; 
    % Jarray(i, k+1) = Jarray(i, k) - C*(Jarray(i, k) - Jarray(i-1, k)); % Marching Equation 
end 

% FYI I had no idea how to do the Neuman boundary conditions so that part I totally was winging it 
