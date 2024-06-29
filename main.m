%_________________________________________________________________________
% Gazelle Optimization Algorithm source code 
%
%  
% paper:
% Jeffrey O. Agushaka, Absalom E. Ezugwu and Laith Abualigah
% Gazelle Optimization Algorithm: A Nature-inspired Metaheuristic
%  
%  
% E-mails: 218088307@stu.ukzn.ac.za            Jeffrey O. Agushaka 
%           ezugwuA@ukzn.ac.za                 Absalom E. Ezugwu
%           aligah@ammanu.edu.jo               Laith Abualigah
%_________________________________________________________________________

clear all
clc
format long
 % Number of search agents
fname = ["F1","F2","F3","F4","F5","F6","F7","F8","F9","F10","F11","F12","F13","F14","F15","F16","F17","F18","F19","F20","F21","F22","F23","F24","F25","F26","F27","F28","F29","F30"];
A  =ones(30,50);
for i=1:30
   for j=1:50
Function_name=fname(i);
   
 % Maximum number of iterations

[lb,ub,dim,fobj] = CEC2017(Function_name);

[Best_Pos,GB1,Convergence_curve] = FHO(fobj,lb,ub,dim);

A(i,j)=GB1;



%display(['The best solution obtained by FHO is : ', num2str(Best_Pos,10)]);
%display(['The best optimal value of the objective function found by FHO is : ', num2str(GB1,10)]);
%disp(sprintf('--------------------------------------'));
end
end