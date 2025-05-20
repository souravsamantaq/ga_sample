% main.m - Run GA to optimize Rastrigin function

clear; clc;

nVars = 5;              % Number of variables (dimensions)
bounds = [-5.12, 5.12]; % Search space
popSize = 50;           % Population size
maxGen = 100;           % Max generations

% Run GA
[bestSol, bestFit] = ga_optimize(@rastrigin, nVars, bounds, popSize, maxGen);

fprintf('Best fitness: %.4f\n', bestFit);
disp('Best solution:');
disp(bestSol);
