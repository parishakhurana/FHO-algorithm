% Define truss node coordinates (x,y)
node_coordinates = [0 0; 3 0; 0 5; 3 5];

% Define element connectivity (node indices for each element)
element_connections = [1 2; 2 3; 1 3; 2 4];

% Define external loads acting on each node (forces in x,y directions)
external_loads = [0 -1000; 3000 1200; 0 0; 0 -2000];

