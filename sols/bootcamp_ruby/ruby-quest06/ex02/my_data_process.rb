def data_processing(rows, cl_number)
    count = Hash.new(0)
    hh_array =  []
    for row in rows
        hh_array << row[cl_number]
    end    
    hh_array.each { |item| count[item] += 1}
    return count
end

def my_data_process(param_1)
    
    result = {}
    headers = param_1[0].split(',')    
    rows = []
    
    param_1.each_with_index do |a, i|
        if i > 0
            rows << a.split(',')
        end
        i += 1
    end
    
    cl = 0
    
    while cl < headers.length
        if cl != 1 && cl != 2 && cl != 3 && cl != 8
            result[headers[cl]] = data_processing(rows, cl)
        end
        cl += 1
    end

    return result.to_json
end