function [ mn bds ] = normal_stats( result )

mn  = nanmean(result);
sem = nanstd(result)/sum(isfinite(result));

bds=  [mn-2*sem, mn+2*sem];
end

