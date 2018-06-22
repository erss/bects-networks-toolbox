function [ mn bds ] = normal_stats( result )

mn  = mean(result);
sem = std(result)/sqrt(length(result));

bds=  [mn-2*sem, mn+2*sem];
end

