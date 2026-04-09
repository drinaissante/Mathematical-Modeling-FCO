function [G, positions, houseMatrix, nodeNames] = node_manager(houses, numHouses, costMatrix)
nodeNames = {'I1','A7','I2','I2-','I3','H2','H3','H4','I4','H5','I5',...
    'I6','I7','I8','H6','H7','H8','H8/I9','I10','H9','H10',...
    'H11','I11','I12','H12','H13','H14','I13','I14','H16','H17'};


% --- Build full graph ---
G = graph(costMatrix, nodeNames, 'upper');

% --- Compute shortest path distances between houses using shortestpath ---
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


% the positions of the nodes
% node positions were taken from google maps
positions = containers.Map( ...
    {'I1','A7','I2','H5','I5','I2-','H2','H3','H4','I4','I6','I3',...
    'I8','I7','H6','H7','H8','H8/I9','I10','H9','H10','H11','I11',...
    'I12','H12','H13','H14','I13','I14','H16','H17'}, ...
    {[1,1],[0,1],[0,2],[1,2],[4,2],[0,3],[1,3],[2,3],[3,3],[4,3],[5,1],[4,1],...
    [9,1],[5,2],[6,2],[7,2],[8,2],[9,2],[5,3],[6,3],[7,3],[8,3],[9,3],...
    [5,4],[5,3.5],[6,4],[7,4],[9,4],[9,3.5],[9,3.2],[9,2.3]} ...
    );
end

