% Filename:Comparison4_rn_modified.m
% Part 4 & 5: the effect of natural-rate-of-interest shock rn under four different policies given modified UIP; Welfare loss

% Run the four models
dynare optimal_rn_3_modified.mod noclearall nograph
% Store IRFs
optimal_rn_results = oo_.irfs;

dynare Domestic_rn_3a_modified.mod noclearall nograph
domestic_rn_results = oo_.irfs;

dynare CPI_rn_3b_modified.mod noclearall nograph
CPI_rn_results = oo_.irfs;

dynare ExPeg_rn_4_modified.mod noclearall nograph
ExPeg_rn_results = oo_.irfs;

% Get the length of IRFs
irf_length = length(optimal_rn_results.piH_eps_rn);
periods = 0:(irf_length-1);

% Create comparison plots
figure('Position', [100, 100, 1200, 800]);

% Domestic Inflation
subplot(2,3,1)
plot(periods, optimal_rn_results.piH_eps_rn, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_rn_results.piH_eps_rn, 'r--', 'LineWidth', 2);
plot(periods, CPI_rn_results.piH_eps_rn, 'b-.', 'LineWidth', 2);
plot(periods, ExPeg_rn_results.piH_eps_rn, 'k-.', 'LineWidth', 2);
title('Domestic Inflation (\pi_H)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
legend('Optimal Policy', 'Domestic inflation', 'CPI inflation', 'Exchange rate peg', 'Location', 'best');
grid on;

% Output Gap
subplot(2,3,2)
plot(periods, optimal_rn_results.x_eps_rn, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_rn_results.x_eps_rn, 'r--', 'LineWidth', 2);
plot(periods, CPI_rn_results.x_eps_rn, 'b-.', 'LineWidth', 2);
plot(periods, ExPeg_rn_results.x_eps_rn, 'k-.', 'LineWidth', 2);
title('Output Gap (x)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

% CPI Inflation
subplot(2,3,3)
plot(periods, optimal_rn_results.pi_eps_rn, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_rn_results.pi_eps_rn, 'r--', 'LineWidth', 2);
plot(periods, CPI_rn_results.pi_eps_rn, 'b-.', 'LineWidth', 2);
plot(periods, ExPeg_rn_results.pi_eps_rn, 'k-.', 'LineWidth', 2);
title('CPI Inflation (\pi)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

% Terms of Trade
subplot(2,3,4)
plot(periods, optimal_rn_results.tau_eps_rn, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_rn_results.tau_eps_rn, 'r--', 'LineWidth', 2);
plot(periods, CPI_rn_results.tau_eps_rn, 'b-.', 'LineWidth', 2);
plot(periods, ExPeg_rn_results.tau_eps_rn, 'k-.', 'LineWidth', 2);
title('Terms of Trade (\tau)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

% Interest Rate
subplot(2,3,5)
plot(periods, optimal_rn_results.i_eps_rn, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_rn_results.i_eps_rn, 'r--', 'LineWidth', 2);
plot(periods, CPI_rn_results.i_eps_rn, 'b-.', 'LineWidth', 2);
plot(periods, ExPeg_rn_results.i_eps_rn, 'k-.', 'LineWidth', 2);
title('Interest Rate (i)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

% Exchange Rate Change
subplot(2,3,6)
plot(periods, optimal_rn_results.delta_e_eps_rn, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_rn_results.delta_e_eps_rn, 'r--', 'LineWidth', 2);
plot(periods, CPI_rn_results.delta_e_eps_rn, 'b-.', 'LineWidth', 2);
plot(periods, ExPeg_rn_results.delta_e_eps_rn, 'k-.', 'LineWidth', 2);
title('Exchange Rate Change (\Delta e)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

sgtitle('Impulse Responses to Natural-rate-of-interest shock (r^n_t) under Different Policies');

% Welfare loss calculation
% Parameters for welfare calculation + Calibration
beta = 0.99;
theta = 0.75;
phi = 3;    
alpha = 0.4;   
epsilon = 6;    

% Derived parameters
lambda = (1 - theta)*(1 - beta*theta)/theta;
lambda_pi = epsilon/(lambda*(1 + phi));
Omega = (1 - alpha)*(1 + phi);

% Construct cumulative welfare loss arrays
cumulative_loss_optimal = zeros(1, irf_length);
cumulative_loss_domestic = zeros(1, irf_length);
cumulative_loss_CPI = zeros(1, irf_length);
cumulative_loss_ExPeg = zeros(1, irf_length);

% Calculate the welfare loss for each period and accumulate it
for t = 1:irf_length
    % Optimal policy welfare loss at time t
    loss_optimal = Omega * 0.5 * (beta^(t-1)) * (optimal_rn_results.x_eps_u(t)^2 + lambda_pi * optimal_rn_results.piH_eps_u(t)^2);
    cumulative_loss_optimal(t) = cumulative_loss_optimal(max(t-1,1)) + loss_optimal;

    % Domestic inflation target policy welfare loss at time t
    loss_domestic = Omega * 0.5 * (beta^(t-1)) * (domestic_rn_results.x_eps_u(t)^2 + lambda_pi * domestic_rn_results.piH_eps_u(t)^2);
    cumulative_loss_domestic(t) = cumulative_loss_domestic(max(t-1,1)) + loss_domestic;

    % CPI inflation target policy welfare loss at time t
    loss_CPI = Omega * 0.5 * (beta^(t-1)) * (CPI_rn_results.x_eps_u(t)^2 + lambda_pi * CPI_rn_results.piH_eps_u(t)^2);
    cumulative_loss_CPI(t) = cumulative_loss_CPI(max(t-1,1)) + loss_CPI;

    % Exchange rate peg policy welfare loss at time t
    loss_ExPeg = Omega * 0.5 * (beta^(t-1)) * (ExPeg_rn_results.x_eps_u(t)^2 + lambda_pi * ExPeg_rn_results.piH_eps_u(t)^2);
    cumulative_loss_ExPeg(t) = cumulative_loss_ExPeg(max(t-1,1)) + loss_ExPeg;
end

% Plot cumulative welfare loss over time
figure;
plot(periods, cumulative_loss_optimal, 'g-', 'LineWidth', 2);
hold on;
plot(periods, cumulative_loss_domestic, 'r--', 'LineWidth', 2);
plot(periods, cumulative_loss_CPI, 'b-.', 'LineWidth', 2);
plot(periods, cumulative_loss_ExPeg, 'k:', 'LineWidth', 2);
title('Cumulative Welfare Loss under Different Policies (r^n_t Shock)');
xlabel('Periods');
ylabel('Cumulative Welfare Loss');
legend('Optimal Policy', 'Domestic inlfation', 'CPI inflation', 'Exchange rate peg', 'Location', 'best');
grid on;
