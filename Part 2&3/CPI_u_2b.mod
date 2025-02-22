// Small Open Economy Model
// Filename: CPI_u_2b.mod
// Examine the effect of cost push shock u under an interest rate policy that targets CPI inflation

var piH          // domestic inflation
    x            // output gap
    pi           // CPI inflation
    tau          // terms of trade
    i            // nominal interest rate
    delta_e      // change in nominal exchange rate
    u            // cost push shock
    rn           // natural rate shock
    z            // foreign output shock
    istar;       // foreign interest rate shock

varexo eps_u     // cost push innovation
       eps_rn     // natural rate innovation
       eps_z     // foreign output innovation
       eps_istar;    // foreign interest rate innovation

parameters beta theta phi alpha epsilon kappa lambda lambda_pi Omega phi_pi rho;

// Calibration
beta = 0.99;     // discount factor
theta = 0.75;    // price stickiness
phi = 3;         // inverse Frisch elasticity
alpha = 0.4;     // openness
epsilon = 6;     // elasticity of substitution
rho = 0.9;       // shock persistence
phi_pi = 1.5;    // Taylor rule coefficient

// Derived parameters
lambda = (1 - theta)*(1 - beta*theta)/theta;
kappa = lambda*(1 + phi);
lambda_pi = epsilon/(lambda*(1 + phi));
Omega = (1 - alpha)*(1 + phi);

// Model Equations
model;
// Phillips Curve (AS)
piH = kappa*x + beta*piH(+1) + u;

// IS Curve (AD)
x = -i + piH(+1) + rn + x(+1);

// CPI inflation relation
pi = piH + alpha*(tau - tau(-1));

// Output relation
x = z + tau;

// Uncovered interest rate parity (UIP)
delta_e = i(-1) - istar(-1);

// Shock processes
u = rho*u(-1) + eps_u;
rn = rho*rn(-1) + eps_rn;
z = rho*z(-1) + eps_z;
istar = rho*istar(-1) + eps_istar;

// Policy rule
// (b) CPI inflation targeting
i = phi_pi*pi;
end;

// Initial Value
initval;
piH = 0;
x = 0;
pi = 0;
tau = 0;
i = 0;
delta_e = 0;
u = 0;
rn = 0;
z = 0;
istar = 0;
end;

// Check steady state
steady;
check;

// Define shocks
shocks;
var eps_u; stderr 1;
var eps_rn; stderr 0;
var eps_z; stderr 0;
var eps_istar; stderr 0;
end;

// Compute impulse response (IRFs)
stoch_simul(order=1, irf=20) piH x pi tau i delta_e;