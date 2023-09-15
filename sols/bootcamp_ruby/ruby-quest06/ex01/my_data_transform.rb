require 'time'
require 'date'

def transformf_datetime(time)
    d = DateTime.parse(time)
    if d.hour >= 6 && d.hour < 12
        return "morning"
    elsif d.hour >= 12 && d.hour < 18
        return "afternoon"
    elsif d.hour >= 18 && d.hour < 24
        return "evening"
    end
end

def transform_age_by_range(age)
    if age < 21
        return "1->20"
    elsif age > 20 && age < 41
        return "21->40"
    elsif age > 40 && age < 66
        return "41->65"
    elsif age > 65
        return "66->99"
    end
end

def transform_email_for_domen(str)
    return str.split("@")[1]
end

def my_data_transform(param_1)

    result = []
    line_number = 0

    for line in param_1.split("\n")

        values = line.split(',')
            
            if values.length > 1 && line_number > 0
                
                values[4] = transform_email_for_domen(values[4])
                values[5] = transform_age_by_range(values[5].to_i)
                values[9] = transformf_datetime(values[9])
                
            end 

            result.append(values.join(','))
            line_number += 1
    end    
    return result
end
