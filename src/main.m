%% Traveling Salesperson with Genetic Algorithm (House + Intersection Integration)

% Parameters
populationSz   = 50;        % good balance for 10 houses
mutationRate   = 0.05;       % mutation probability
numGenerations = 600;        % iterations

% --- Load cost matrix ---
rawData   = readmatrix('AdjacencyMatrix.csv','NumHeaderLines',1);
costMatrix = rawData(:,2:end);   % remove first column

% --- Define node names ---
nodeNames = {'I1','A7','I2','I2-','I3','H2','H3','H4','I4','H5','I5',...
    'I6','I7','I8','H6','H7','H8','H8/I9','I10','H9','H10',...
    'H11','I11','I12','H12','H13','H14','I13','I14','H16','H17'};

% --- Separate houses and intersections ---
houses = {'H2','H3','H4','H5','H6','H7','H8','H9','H10','H11', 'H12', 'H13', 'H14', 'H16', 'H17'}; % required visits
numHouses = numel(houses);

% --- Build full graph ---
G = graph(costMatrix,nodeNames,'upper');

% --- Compute shortest path distances between houses ---
houseMatrix = zeros(numHouses);
for i = 1:numHouses
    for j = 1:numHouses
        if i ~= j
            [~, d] = shortestpath(G, houses{i}, houses{j});
            houseMatrix(i,j) = d;
        else
            houseMatrix(i,j) = 0;
        end
    end
end

maxCapacity = 5; % maximum houses per run
selectedHouses = randperm(numHouses, maxCapacity);
population = zeros(populationSz, maxCapacity);
for i = 1:populationSz
    population(i,:) = selectedHouses(randperm(maxCapacity));
end

fitness        = zeros(populationSz,1);
bestEver       = [];
recordDistance = inf;

%% Helper: distance of a route using houseMatrix
calcDistance = @(order) ...
    sum(arrayfun(@(k) houseMatrix(order(k), order(k+1)), 1:length(order)-1)) + ...
    houseMatrix(order(end), order(1));

numRuns = 5; % number of GA runs

bestDistances = zeros(numRuns,1);
bestFullRoute = cell(numRuns,1);
best = 0;

% the positions of the nodes
positions = containers.Map( ...
    {'I1','A7','I2','H5','I5','I2-','H2','H3','H4','I4','I6','I3',...
    'I8','I7','H6','H7','H8','H8/I9','I10','H9','H10','H11','I11',...
    'I12','H12','H13','H14','I13','I14','H16','H17'}, ...
    {[1,1],[0,1],[0,2],[1,2],[4,2],[0,3],[1,3],[2,3],[3,3],[4,3],[5,1],[4,1],...
    [9,1],[5,2],[6,2],[7,2],[8,2],[9,2],[5,3],[6,3],[7,3],[8,3],[9,3],...
    [5,4],[5,3.5],[6,4],[7,4],[9,4],[9,3.5],[9,3.2],[9,2.3]} );

maxCapacity = 15; % maximum houses per run

for run = 1:numRuns
    %% --- Initialize population (permutations of houses) ---
    selectedHouses = randperm(numHouses, maxCapacity);
    population = zeros(populationSz, maxCapacity);
    for i = 1:populationSz
        population(i,:) = selectedHouses(randperm(maxCapacity));
    end


    fitness        = zeros(populationSz,1);
    bestEver       = [];
    recordDistance = inf;

    %% GA loop
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
            orderA = pickOne(population, fitness);
            orderB = pickOne(population, fitness);
            order  = crossOver(orderA, orderB);
            order  = mutate(order, mutationRate);
            newPopulation(i,:) = order;
        end
        population = newPopulation;
    end

    %% --- Expand Best Route (start/end at I1) ---
    expandedPath = {};
    expandedEdges = [];
    totalDist = 0;

    fullRoute = [{'I1'}, houses(bestEver), {'I1'}];

    for k = 1:length(fullRoute)-1
        [path, d] = shortestpath(G, fullRoute{k}, fullRoute{k+1});
        totalDist = totalDist + d;
        expandedPath = [expandedPath, path];
        for p = 1:length(path)-1
            expandedEdges = [expandedEdges; find(strcmp(nodeNames,path{p})), find(strcmp(nodeNames,path{p+1}))];
        end
    end

    % %% --- Visualization 1: Full Network with Route Highlighted ---
    % figure;
    % h = plot(G,'Layout','force','NodeLabel',nodeNames);
    % h.EdgeLabel = G.Edges.Weight;

    % for k = 1:size(expandedEdges,1)
    %     u = expandedEdges(k,1);
    %     v = expandedEdges(k,2);
    %     if findedge(G,u,v) > 0
    %         highlight(h,u,v,'EdgeColor','r','LineWidth',3);
    %     end
    % end

    % expandedNodeIdx = cellfun(@(x) find(strcmp(nodeNames,x)), unique(expandedPath));
    % highlight(h, expandedNodeIdx,'NodeColor','r','MarkerSize',7);

    % title(sprintf('Run %d Best Route (with intersections, start/end at I1), Distance = %.2f', run, totalDist));

    %% --- Output Expanded Route Table ---
    fprintf('\nRun %d Expanded Best Route (including intersections, start/end at I1):\n', run);
    fprintf('-----------------------------------\n');
    for k = 1:length(fullRoute)-1
        [path, d] = shortestpath(G, fullRoute{k}, fullRoute{k+1});
        fprintf('%s', path{1});
        for p = 2:length(path)
            fprintf(' -> %s', path{p});
        end
        fprintf(' : %.2f\n', d);
    end
    fprintf('-----------------------------------\n');
    fprintf('Total Distance (Run %d): %.2f\n\n', run, totalDist);

    %% --- Visualization 2: Clean Route-Only Graph with Custom Positions ---
    uniqueNodes = unique(expandedPath);
    subIdx = cellfun(@(x) find(strcmp(nodeNames,x)), uniqueNodes);
    subMatrix = costMatrix(subIdx, subIdx);
    subNames = nodeNames(subIdx);

    % Extract positions for the subgraph nodes
    X = zeros(1,length(subIdx));
    Y = zeros(1,length(subIdx));
    for i = 1:length(subIdx)
        coords = positions(subNames{i});
        X(i) = coords(1);
        Y(i) = coords(2);
    end

    figure;
    subG = graph(subMatrix, subNames, 'upper');
    h2 = plot(subG,'XData',X,'YData',Y,'NodeLabel',subNames);
    h2.EdgeLabel = subG.Edges.Weight;

    for k = 1:size(expandedEdges,1)
        u = expandedEdges(k,1);
        v = expandedEdges(k,2);
        if ismember(u,subIdx) && ismember(v,subIdx)
            highlight(h2, find(subIdx==u), find(subIdx==v), 'EdgeColor','r','LineWidth',3);
        end
    end

    highlight(h2, 1:length(subIdx),'NodeColor','r','MarkerSize',7);

    bestFullRoute{run} = fullRoute;        % store the route for this run
    bestDistances(run) = totalDist;        % store the distance for this run


    title(sprintf('Run %d Clean Expanded Route (fixed positions), Distance = %.2f', run, totalDist));
end

[bestDist, bestRun] = min(bestDistances);
bestRoute = bestFullRoute{bestRun};

fprintf('Best Run Total Distance = %d\n', bestDist);
%% --- Output Expanded Route Table ---
for k = 1:length(bestRoute)-1
    [path, d] = shortestpath(G, bestRoute{k}, bestRoute{k+1});
    fprintf('%s', path{1});
    for p = 2:length(path)
        fprintf(' -> %s', path{p});
    end
    fprintf(' : %.2f\n', d);
end
fprintf('-----------------------------------\n');


