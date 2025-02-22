% Filename: comparison3_istar.m
% Part 3: the effect of foreign-interest-rate shock istar under three different policies

% Run the three models
dynare Optimal_istar_3.mod noclearall nograph
% Store IRFs
optimal_istar_results = oo_.irfs;

dynare Domestic_istar_3a.mod noclearall nograph
domestic_istar_results = oo_.irfs;

dynare CPI_istar_3b.mod noclearall nograph
CPI_istar_results = oo_.irfs;

% Length of IRFs
irf_length = length(optimal_istar_results.piH_eps_istar);
periods = 0:(irf_length - 1);

% Create comparison plots
figure('Position', [100, 100, 1200, 800]);

% Domestic Inflation
subplot(2,3,1)
plot(periods, optimal_istar_results.piH_eps_istar, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_istar_results.piH_eps_istar, 'r--', 'LineWidth', 2);
plot(periods, CPI_istar_results.piH_eps_istar, 'b-.', 'LineWidth', 2);
title('Domestic Inflation (\pi_H)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
legend('Optimal Policy', 'Domestic inflation', 'CPI inflation', 'Location', 'best');
grid on;

% Output Gap
subplot(2,3,2)
plot(periods, optimal_istar_results.x_eps_istar, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_istar_results.x_eps_istar, 'r--', 'LineWidth', 2);
plot(periods, CPI_istar_results.x_eps_istar, 'b-.', 'LineWidth', 2);
title('Output Gap (x)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

% CPI Inflation
subplot(2,3,3)
plot(periods, optimal_istar_results.pi_eps_istar, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_istar_results.pi_eps_istar, 'r--', 'LineWidth', 2);
plot(periods, CPI_istar_results.pi_eps_istar, 'b-.', 'LineWidth', 2);
title('CPI Inflation (\pi)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

% Terms of Trade
subplot(2,3,4)
plot(periods, optimal_istar_results.tau_eps_istar, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_istar_results.tau_eps_istar, 'r--', 'LineWidth', 2);
plot(periods, CPI_istar_results.tau_eps_istar, 'b-.', 'LineWidth', 2);
title('Terms of Trade (\tau)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

% Interest Rate
subplot(2,3,5)
plot(periods, optimal_istar_results.i_eps_istar, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_istar_results.i_eps_istar, 'r--', 'LineWidth', 2);
plot(periods, CPI_istar_results.i_eps_istar, 'b-.', 'LineWidth', 2);
title('Interest Rate (i)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

% Exchange Rate Change
subplot(2,3,6)
plot(periods, optimal_istar_results.delta_e_eps_istar, 'g-', 'LineWidth', 2);
hold on;
plot(periods, domestic_istar_results.delta_e_eps_istar, 'r--', 'LineWidth', 2);
plot(periods, CPI_istar_results.delta_e_eps_istar, 'b-.', 'LineWidth', 2);
title('Exchange Rate Change (\Delta e)');
xlabel('Quarters');
ylabel('Deviation from Steady State');
grid on;

sgtitle('Impulse Responses to Foreign-interest-rate shock (i^*_t) under Different Policies');