% Define the data points for the curves
compositionL = [0 75 100]; % Composition (% MgO)
compositionS = [0 64 100]; % Composition (% MgO)
liquidus_temp = [1902 3251 3477]; % Liquidus temperatures (°C)
solidus_temp = [1902 2724 3477]; % Solidus temperatures (°C)

% Generate a finer composition range for smoother curves
composition_fine = linspace(0, 100, 100);

% Interpolate using cubic splines
liquidus_smooth = interp1(compositionL, liquidus_temp, composition_fine, 'pchip');
solidus_smooth = interp1(compositionS, solidus_temp, composition_fine, 'pchip');

%% Create a label array for liquidus and solidus curves (all labels are 1)
labels_curve = ones(size(composition_fine')); % Ensure labels match the size of the fine composition

% Create tables for liquidus and solidus data with consistent structure
curve_data_liquidus = table(composition_fine', liquidus_smooth', labels_curve, ...
    'VariableNames', {'Composition_Percent_Ni', 'Temperature_C', 'Label'});
curve_data_solidus = table(composition_fine', solidus_smooth', labels_curve, ...
    'VariableNames', {'Composition_Percent_Ni', 'Temperature_C', 'Label'});

% Combine liquidus and solidus data into a single table
curve_data_combined = [curve_data_liquidus; curve_data_solidus];

%% Create 1000 random data points in the range of the phase diagram
rng(0); % Set random seed for reproducibility
random_compositions = rand(1000, 1) * 100; % Random compositions in the range [0, 100]
random_temperatures = rand(1000, 1) * (max(liquidus_temp) - min(solidus_temp)) + min(solidus_temp); % Random temperatures

% Determine if each point lies exactly on the liquidus or solidus curve
labels_random = zeros(1000, 1); % Initialize labels
tolerance = 15; % Set a small tolerance for floating-point comparisons

for i = 1:1000
    comp = random_compositions(i);
    temp = random_temperatures(i);
    
    % Interpolate to find the liquidus and solidus temperature at this composition
    liq_temp = interp1(composition_fine, liquidus_smooth, comp, 'linear', 'extrap');
    sol_temp = interp1(composition_fine, solidus_smooth, comp, 'linear', 'extrap');
    
    % Check if the temperature is exactly on the liquidus or solidus curve
    if abs(temp - liq_temp) < tolerance || abs(temp - sol_temp) < tolerance
        labels_random(i) = 1; % Label as being on the curve
    end
end

%% Create a table for the random points
random_data = table(random_compositions, random_temperatures, labels_random, ...
    'VariableNames', {'Composition_Percent_Ni', 'Temperature_C', 'Label'});

% Combine the curve data and random data into one table
combined_data = [curve_data_combined; random_data];

% Save the combined data to a CSV file
writetable(combined_data, 'MF_phase_diagram_with_labels_5GPa.csv');

%% Optional: Plot the phase diagram and random points for verification
figure;
hold on;
plot(composition_fine, liquidus_smooth, 'r-', 'LineWidth', 2, 'DisplayName', 'Liquidus Curve');
plot(composition_fine, solidus_smooth, 'b-', 'LineWidth', 2, 'DisplayName', 'Solidus Curve');
scatter(random_compositions(labels_random == 1), random_temperatures(labels_random == 1), 10, 'g', 'filled', 'DisplayName', 'Points Exactly on Curve');
scatter(random_compositions(labels_random == 0), random_temperatures(labels_random == 0), 10, 'k', 'DisplayName', 'Random Points Not on Curve');
xlabel('Composition (% MgO)');
ylabel('Temperature (K)');
title('Phase Diagram with Labeled Random Points');
legend('show');
grid on;
hold off;

disp('Phase diagram with labeled random data saved to phase_diagram_with_exact_labels.csv');
