% Include necessary files
run('Truss_Geometry.m');
run('Truss_Material.m');

% Define problem parameters (replace with your values)
lb = 0;  % Minimum element length (meters)
ub = 5;  % Maximum element length (meters)

% Call the FHO function with objective function and parameters
[Best_Pos, GB, Convergence_curve] = FHO(@objectiveFunction, lb, ub, size(element_connections,1));

% Print results
disp('Optimal Design Vector FHO Original(element lengths):');
disp(Best_Pos);
disp('Minimum Weight:');
disp(GB);

% Optional: Plot convergence curve (requires additional code)
% plot(Convergence_curve)


[Best_Pos, GB, Convergence_curve] = FHO_2best(@objectiveFunction, lb, ub, size(element_connections,1));
disp('Optimal Design Vector FHO_2best (element lengths):');
disp(Best_Pos);
disp('Minimum Weight:');
disp(GB);




[Best_Pos, GB, Convergence_curve] = FHO_upgrade(@objectiveFunction, lb, ub, size(element_connections,1));
disp('Optimal Design Vector FHO_upgrade (element lengths):');
disp(Best_Pos);
disp('Minimum Weight:');
disp(GB);



[Best_Pos, GB, Convergence_curve] = FHO_nearGB(@objectiveFunction, lb, ub, size(element_connections,1));
disp('Optimal Design Vector FHO_nearGB (element lengths):');
disp(Best_Pos);
disp('Minimum Weight:');
disp(GB);

[Best_Pos, GB, Convergence_curve] = FHO_dist_upgrade(@objectiveFunction, lb, ub, size(element_connections,1));
disp('Optimal Design Vector FHO_dist_upgrade (element lengths):');
disp(Best_Pos);
disp('Minimum Weight:');
disp(GB);
