function create_graph(run, expandedPath, nodeNames, costMatrix, positions, expandedEdges, totalDist)
uniqueNodes = unique(expandedPath);
subIdx = cellfun(@(x) find(strcmp(nodeNames,x)), uniqueNodes);
subMatrix = costMatrix(subIdx, subIdx);
subNames = nodeNames(subIdx);

% extract positions for the subgraph nodes
X = zeros(1,length(subIdx));
Y = zeros(1,length(subIdx));
for i = 1:length(subIdx)
    coords = positions(subNames{i});
    X(i) = coords(1);
    Y(i) = coords(2);
end

% create figure (graph)
figure;

subG = graph(subMatrix, subNames, 'upper');
h2 = plot(subG, 'XData',X , 'YData', Y, 'NodeLabel', subNames);
h2.EdgeLabel = subG.Edges.Weight;

for k = 1:size(expandedEdges, 1)
    u = expandedEdges(k, 1);
    v = expandedEdges(k, 2);

    if ismember(u, subIdx) && ismember(v, subIdx)
        highlight(h2, find(subIdx == u), find(subIdx == v), 'EdgeColor','r','LineWidth',3);
    end
end

% highlight the matching route
highlight(h2, 1:length(subIdx),'NodeColor','r','MarkerSize',7);

title(sprintf('Run %d, Distance = %.2f', run, totalDist));
end