%% Traveling Salesperson (TSP) with Genetic Algorithm (GA)

% import folder to find functions for GA
addpath('genetic_algorithm/');
addpath(genpath('pwd'));

%% --- Load cost / adjacency matrix ---
rawData = readmatrix('resources/AdjacencyMatrix.csv', 'NumHeaderLines', 1);
costMatrix = rawData(:,2:end);   % remove first column (header)

%% --- Setting up nodes ---
houses = {'H2', 'H3', 'H4', 'H5', 'H6', 'H7', 'H8', 'H9', 'H10', 'H11', 'H12', 'H13', 'H14', 'H16', 'H17'}; % required visits
numHouses = numel(houses);

% get the G (graph), node positions, house matrix, names of the nodes of the graph
[G, positions, houseMatrix, nodeNames] = node_manager(houses, numHouses, costMatrix);

% distance of a route using houseMatrix
calcDistance = @(order) ...
    sum(arrayfun(@(k) houseMatrix(order(k), order(k + 1)), 1:length(order) - 1)) + ...
    houseMatrix(order(end), order(1));
%% --- Genetic Algorithm Parameters ---
populationSz = 50;
mutationRate = 0.05; % mutation probability
numGenerations = 600; % iteration for GA

numRuns = 10; % number of GA runs
maxCapacity = 15; % maximum houses per run

%% --- Tracking for best ---
% to track for best distances and route for results
bestDistances = zeros(numRuns,1);
bestFullRoute = cell(numRuns,1);
best = 0;

%% --- The loop for number of runs --
for run = 1:numRuns
    %% --- Initialize population (permutations of houses) ---
    selectedHouses = randperm(numHouses, maxCapacity); % create a row vector perm(utation)
    population = zeros(populationSz, maxCapacity);
    for i = 1:populationSz
        population(i,:) = selectedHouses(randperm(maxCapacity));
    end

    %% --- GA fitness and also tracking ---
    fitness = zeros(populationSz,1);
    recordDistance = inf;

    %% --- GA loop ---
    bestEver = genetic_algorithm(numGenerations, populationSz, mutationRate, calcDistance, population, recordDistance, fitness);

    %% --- Optimal Route ---
    expandedPath = {};
    expandedEdges = [];
    totalDist = 0;

    % fullRoute must start with I1 and end with I1 for TSP
    fullRoute = [{'I1'}, houses(bestEver), {'I1'}];

    for k = 1:length(fullRoute) - 1
        [path, d] = shortestpath(G, fullRoute{k}, fullRoute{k+1});

        totalDist = totalDist + d;
        expandedPath = [expandedPath, path];

        for p = 1:length(path)-1
            expandedEdges = [expandedEdges; find(strcmp(nodeNames,path{p})), find(strcmp(nodeNames,path{p+1}))];
        end
    end

    %% --- Show Optimal Route Path ---
    show_route(G, run, fullRoute, totalDist, false);

    %% --- Show Results ---
    create_graph(run, expandedPath, nodeNames, costMatrix, positions, expandedEdges, totalDist);

    bestFullRoute{run} = fullRoute; % (tracking) store the route for this run
    bestDistances(run) = totalDist; % (tracking)store the distance for this run
end

%% --- Final Best Route (of all runs) ---
[bestDist, bestRun] = min(bestDistances); % find the best minimum
bestRoute = bestFullRoute{bestRun};

show_route(G, bestRun, bestRoute, bestDist, true);