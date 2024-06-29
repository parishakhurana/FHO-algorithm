clear all
clc
delete(gcp('nocreate'))
% Pre-allocate arrays for storing results
results_matrix = zeros(30, 2); % 30 functions, 2 algorithms (AOA, MAOA)
p_values = zeros(1, 30); % Stores p-values from Wilcoxon Rank Sum test
summary_matrix = zeros(30, 3);
pool = parpool('local', 'AttachedFiles' , {'CEC2017.m', 'FHO.m', 'FHO_2best.m', 'FHO_dist_upgrade.m', 'FHO_nearGB.m', 'main.m', 'RWFHO.m'});

parfor i = 1:30 % Loop over each function from F1 to F30
    if i == 2
        continue;
    end
    F_name = ['F', num2str(i)]; % Name of the test function
    [lb, ub, dim, fobj] = CEC2017(F_name);
    
    % Run multiple times and store best scores for each algorithm
    FHO_matrix = zeros(1, 30);
    FHO_up_matrix = zeros(1, 30);
    for run = 1:50
        [~, GB_norm, ~] = FHO(fobj, lb, ub, dim);
        [~, GB_up, ~] = FHO_nearGB(fobj, lb, ub, dim);
        FHO_matrix(run) = GB_norm;
        FHO_up_matrix(run) = GB_up;
    end
    
    % Calculate Wilcoxon Rank Sum test and store p-value
    [p_values(i), ~, ~] = ranksum(FHO_matrix, FHO_up_matrix);
    
    % Update results matrix with best score for each run
    min_FHO_matrix = min(FHO_matrix); % Assuming lower score is better
    min_FHO_up_matrix = min(FHO_up_matrix); % Assuming lower score is better

    % Update results_matrix using slicing
    results_matrix(i, :) = [min_FHO_matrix, min_FHO_up_matrix];

    % Update summary_matrix using slicing
    summary_matrix(i, :) = [mean(FHO_matrix), mean(FHO_up_matrix), p_values(i)];
    
    % Display results (modify as needed)
    disp(['For function ', F_name, ':']);
    disp(['Best score by FHO (average of 50 runs): ', num2str(mean(FHO_matrix))]);
    disp(['Best score by UFHO (average of 50 runs): ', num2str(mean(FHO_up_matrix))]);
    disp(['p-value (Wilcoxon Rank Sum): ', num2str(p_values(i))]);
    disp('\n');
end

% Display or further process the results matrix and p-values
disp('Results Matrix:');
disp(results_matrix);
disp('p-values:');
disp(p_values);
delete(gcp('nocreate'))