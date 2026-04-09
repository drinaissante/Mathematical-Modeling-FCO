function order = ga_selection(population, prob)
r = rand;
index = 1;

while r > 0
    r = r - prob(index);

    index = index + 1;

    if index > length(prob)
        index = length(prob);
        break;
    end
end

index = index - 1;
order = population(index,:);

end