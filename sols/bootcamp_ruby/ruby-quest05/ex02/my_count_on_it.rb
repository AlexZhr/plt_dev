def my_count_on_it(param_1)
    param_1.collect do |a|
        a.length
    end
end

#i = 0
#array = Array.new
#while(i < param_1.length)
#    array[i] = param_1[i].length
#    i += 1
#end
#return array