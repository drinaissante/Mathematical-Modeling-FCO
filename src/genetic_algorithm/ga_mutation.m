function order = ga_mutation(order, mutationRate)
for i = 1:length(order)
    if rand < mutationRate
        idxA = randi(length(order));
        idxB = randi(length(order));
        tmp = order(idxA);
        order(idxA) = order(idxB);
        order(idxB) = tmp;
    end
end
end