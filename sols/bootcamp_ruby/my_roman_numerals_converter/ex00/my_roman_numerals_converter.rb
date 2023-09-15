#!/usr/bin/env ruby
#=begin
def thousands(numb)
    r_nbmr = String.new
    if numb < 4
        i = 0
        until i == numb
            r_nbmr += 'M'
            i += 1
        end
    end
    return r_nbmr
end

def hundreds(numb)
    r_nbmr = String.new
    if numb < 4
        i = 0
        until i == numb
            r_nbmr += 'С'
            i += 1
        end
    elsif numb == 4
        r_nbmr += 'СD'
    elsif numb == 5
        r_nbmr += 'D'
    elsif numb == 6
        r_nbmr += 'DC'
    elsif numb == 7
        r_nbmr += 'DCC'
    elsif numb == 8
        r_nbmr += 'DCCC'
    elsif numb == 9
        r_nbmr += 'CM'
    end
    return r_nbmr
end

def tens(numb)
    r_nbmr = String.new
    if numb < 4
        i = 0
        until i == numb
            r_nbmr += 'X'
            i += 1
        end
    elsif numb == 4
        r_nbmr += 'XL'
    elsif numb == 5
        r_nbmr += 'L'
    elsif numb == 6
        r_nbmr += 'LX'
    elsif numb == 7
        r_nbmr += 'LXX'
    elsif numb == 8
        r_nbmr += 'LXXX'
    elsif numb == 9
        r_nbmr += 'XC'
    end
    return r_nbmr
end

def units(numb)
    r_nbmr = String.new
    if numb < 4
        i = 0
        until i == numb
            r_nbmr += 'I'
            i += 1
        end
    elsif numb == 4
        r_nbmr += 'IV'
    elsif numb == 5
        r_nbmr += 'V'
    elsif numb == 6
        r_nbmr += 'VI'
    elsif numb == 7
        r_nbmr += 'VII'
    elsif numb == 8
        r_nbmr += 'VIII'
    elsif numb == 9
        r_nbmr += 'IX'
    end
    return r_nbmr
end
#=end

def my_roman_numerals_converter(param_1)

    result = String.new
    vlstr = param_1.to_s.chars
    ln = vlstr.length

    if ln == 1
        result += units(vlstr[0].to_i)
    elsif ln == 2
        result += tens(vlstr[0].to_i) + units(vlstr[1].to_i)
    elsif ln == 3
        result += hundreds(vlstr[0].to_i) + tens(vlstr[1].to_i) + units(vlstr[2].to_i)
    elsif ln == 4
        result += thousands(vlstr[0].to_i) + hundreds(vlstr[1].to_i) + tens(vlstr[2].to_i) + units(vlstr[3].to_i)
    end

    return result
end
