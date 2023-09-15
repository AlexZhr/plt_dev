def my_is_sort(param_1)
    i=1
    while i < param_1.length - 1
        if(param_1[i] > param_1[i-1] && param_1[i] > param_1[i+1])            
            return false
        elsif(param_1[i] < param_1[i-1] && param_1[i] < param_1[i+1])    
            return false
        end
        i += 1
    end
    return true
end