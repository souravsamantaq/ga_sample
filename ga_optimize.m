% ga_optimize.m - Simple Genetic Algorithm implementation


function [bestSol, bestFit] = ga_optimize(objFunc, nVars, bounds, popSize, maxGen)

    % Initialize population
    pop = bounds(1) + (bounds(2) - bounds(1)) * rand(popSize, nVars);
    fitness = zeros(popSize, 1);
    for i = 1:popSize
        fitness(i) = objFunc(pop(i, :));
    end

    for gen = 1:maxGen
        % Selection: Tournament
        selected = zeros(size(pop));
        for i = 1:popSize
            a = randi(popSize);
            b = randi(popSize);
            if fitness(a) < fitness(b)
                selected(i, :) = pop(a, :);
            else
                selected(i, :) = pop(b, :);
            end
        end

        % Crossover: Single point
        offspring = zeros(size(pop));
        for i = 1:2:popSize
            if i+1 > popSize, break; end
            cp = randi(nVars - 1);
            offspring(i, :) = [selected(i, 1:cp), selected(i+1, cp+1:end)];
            offspring(i+1, :) = [selected(i+1, 1:cp), selected(i, cp+1:end)];
        end

        % Mutation
        mutationRate = 0.1;
        mutation = mutationRate * (rand(size(offspring)) - 0.5) * (bounds(2) - bounds(1));
        offspring = offspring + mutation;
        offspring = max(min(offspring, bounds(2)), bounds(1));

        % Evaluate offspring
        offspringFitness = zeros(popSize, 1);
        for i = 1:popSize
            offspringFitness(i) = objFunc(offspring(i, :));
        end

        % Elitism: Keep best individuals
        combined = [pop; offspring];
        combinedFitness = [fitness; offspringFitness];

        [~, idx] = sort(combinedFitness);
        pop = combined(idx(1:popSize), :);
        fitness = combinedFitness(idx(1:popSize));
    end

    [bestFit, bestIdx] = min(fitness);
    bestSol = pop(bestIdx, :);
end
