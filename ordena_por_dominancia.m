function f = ordena_por_dominancia(x)

[N, ~] = size(x);
dominatedBy = zeros(N,1);

for i = 1 : N
    dominatedBy(i) = 0;
    for j = 1 : N
        lessThan = 0;
        equalThan = 0;
        for k = 2 : 3
            fki = x(i,k);
            fkj = x(j,k);
            if fki < fkj
                lessThan = lessThan + 1;
            elseif fki == fkj
                equalThan = equalThan + 1;
            end
        end
        
        if lessThan == 0 && equalThan ~= 2
            dominatedBy(i) = dominatedBy(i) + 1;
        end
    end
end

[~,indexes] = sort(dominatedBy);
for i = 1 : length(indexes)
    sorted(i,:) = x(indexes(i),:);
end
f = sorted;
