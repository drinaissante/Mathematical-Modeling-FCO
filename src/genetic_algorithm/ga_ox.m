function neworder = ga_cox(orderA, orderB)
start = randi(length(orderA));
endIdx = randi([start length(orderA)]);
neworder = orderA(start:endIdx);
for i = 1:length(orderB)
    city = orderB(i);
    if ~ismember(city,neworder)
        neworder(end+1) = city;
    end
end
end