function best = genetic_algorithm(numGenerations, populationSz, mutationRate, calcDistance, population, recordDistance, fitness)
bestEver = [];

for gen = 1:numGenerations
    % --- 1. Fitness calculation ---
    for i = 1:populationSz
        d = calcDistance(population(i,:));
        if d < recordDistance
            recordDistance = d;
            bestEver = population(i,:);
        end
        fitness(i) = 1 / (d^8 + 1);
    end

    % --- 2. Normalize fitness ---
    fitness = fitness ./ sum(fitness);

    % --- 3. Next generation ---
    newPopulation = zeros(size(population));

    for i = 1:populationSz
        orderA = ga_selection(population, fitness);
        orderB = ga_selection(population, fitness);

        order  = ga_ox(orderA, orderB);
        order  = ga_mutation(order, mutationRate);

        newPopulation(i,:) = order;
    end

    population = newPopulation;
end

best = bestEver;
end