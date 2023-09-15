def my_csv_parser(param_1, param_2)
    array = param_1.split("\n")
    i = 0
    array2d = Array.new
    while i < array.length
        array2d[i] = array[i].split(param_2)
        i += 1
    end
    return array2d
end