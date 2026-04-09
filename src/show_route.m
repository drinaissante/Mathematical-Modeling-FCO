function show_route(G, run, fullRoute, totalDist, final)

fprintf('-----------------------------------\n');

if final
    fprintf("THE FINAL BEST ROUTE: Run %d\n", run);
else
    fprintf("ROUTE Run: %d\n", run);
end

fprintf('-----------------------------------\n');

%% --- Route Path ---
for k = 1:length(fullRoute) - 1
    [path, d] = shortestpath(G, fullRoute{k}, fullRoute{k + 1});

    fprintf('%s', path{1});

    for p = 2:length(path)
        fprintf(' -> %s', path{p});
    end

    fprintf(' : %.2f\n', d);
end
fprintf('-----------------------------------\n');

if final
    fprintf("(BEST) ");
end

fprintf('Total Distance (Run %d): %.2f\n\n', run, totalDist);

end