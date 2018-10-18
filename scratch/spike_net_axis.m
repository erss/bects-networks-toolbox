
t = model006.t;
window_step = 0.5;
window_size = 1;
i_total = 1+floor((t(end)-t(1)-window_size) /window_step);
net_left = [];
net_right = [];
for  k = 1:i_total
    t_start = t(1) + (k-1) * window_step;   %... get window start time [s],
    t_stop  = t_start + window_size;                  %... get window stop time [s],
    indices = find(t >= t_start & t < t_stop);
    
    for p = 1:length(left_events)
        if sum(left_events(p)==indices)==1
            net_left = [net_left k];
        end
    end
    
    for p = 1:length(right_events)
        if sum(right_events(p)==indices)==1
            net_right = [net_right k];
        end
    end
    
   

end