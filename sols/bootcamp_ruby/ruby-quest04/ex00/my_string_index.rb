def my_string_index(param_1, param_2)
    i = 0
    while(i < param_1.length) 
        if(param_1[i] == param_2) 
            return i   
        end     
        i += 1
    end
    return -1
end