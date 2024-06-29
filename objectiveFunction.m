 function fitness = objectiveFunction(design_vector)
   % This function calculates the total weight of a truss structure
   % subject to stress constraints on elements.
 
   % Design variables (replace with actual number of variables)
 
 
    element_lengths = design_vector;  % Assuming design vector holds element lengths
 
 
 
 
   % Material properties (replace with actual values)
   density = 7800;  % kg/m^3
 
   % Truss geometry and loads (replace with your specific data)
   % This example defines a simple 2D truss with 4 elements
   node_coordinates = [0 0; 3 0; 0 5; 3 5];  % (x,y) coordinates of nodes
   element_connections = [1 2; 2 3; 1 3; 2 4];  % Connectivity matrix (node indices)
   external_loads = [0 -1000; 3000 0; 0 0; 0 -2000];  % External forces at nodes
 
   % Element stresses (replace with your analysis method)
   % This example assumes a simple truss analysis for demonstration
   element_stresses = zeros(size(element_connections,1),1);
   for i = 1:size(element_connections,1)
     node1 = element_connections(i,1);
     node2 = element_connections(i,2);
     dx = node_coordinates(node2,1) - node_coordinates(node1,1);
     dy = node_coordinates(node2,2) - node_coordinates(node1,2);
     element_length = element_lengths(i);
     force_x = external_loads(node1,1) + external_loads(node2,1);
     force_y = external_loads(node1,2) + external_loads(node2,2);
     element_stresses(i) = (force_x*dx + force_y*dy) / element_length;
   end
 
   % Allowable stress (replace with actual material limit)
   allowable_stress = 250e6;  % Pa
 
   % Penalty factor (adjust based on your problem)
   penalty_factor = 10^6;
 
   % Objective function (minimize total weight with stress penalty)
   fitness = sum(element_lengths) * density;
   for i = 1:size(element_stresses,1)
     if abs(element_stresses(i)) > allowable_stress
       fitness = fitness + penalty_factor * abs(element_stresses(i) - allowable_stress);
     end
   end
 end



