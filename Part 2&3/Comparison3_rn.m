% Filename: comparison3_rn.m
% Part 3: the effect of natural-rate-of-interest shock rn under three different policies

% Run the three models
dynare Optimal_rn_3.mod noclearall nograph
% Store IRFs
optimal_rn_results = oo_.irfs;

dynare Domestic_rn_3a.mod noclearall nograph
domestic_rn_results = oo_.irfs;

dynare CPI_rn_3b.mod noclearall nograph
CPI_rn_results = oo_.irfs;

% Length of IRFs
irf_length = length(optimal_rn_results.piH_eps_rn);
periods = 0:(irf_length - 1);

% Create comparison plots
figure('Position', [100, 100, 1200, 800]);

% Domestic Inflation
subplot(2,3,1)
plot(periods, optimal_rn_results.piH_eps_rn, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_rn_results.piH_eps_rn, 'r--', 'LineWidth', 2);
plot(periods, CPI_rn_results.piH_eps_rn, 'b-.', 'LineWidth', 2);
title('Domestic Inflation (\pi_H)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
legend('Optimal Policy', 'Domestic inflation', 'CPI inflation', 'Location', 'best');
grid on;

% Output Gap
subplot(2,3,2)
plot(periods, optimal_rn_results.x_eps_rn, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_rn_results.x_eps_rn, 'r--', 'LineWidth', 2);
plot(periods, CPI_rn_results.x_eps_rn, 'b-.', 'LineWidth', 2);
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
title('Exchange Rate Change (\Delta e)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

sgtitle('Impulse Responses to Natural-rate-of-interest shock (r^n_t) under Different Policies');