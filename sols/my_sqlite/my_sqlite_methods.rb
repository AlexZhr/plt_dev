# frozen_string_literal: true

# rubocop:disable Metrics/BlockNesting, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/Documentation

module CLImethods
    # The method takes a string (str) as input, which represents a command or query.
    def parser(str)
        initial_row = str

        # Splitting the string based on different delimiters to create an array `str`.
        # If the string contains " ( " or " ) ", split using regular expressions and remove surrounding spaces.
        if str.include?(' (' || ') ')
            str = str.split(/\s*\(\s*|\s*\)\s*/)
            str[0] = str[0].split
        # If the string contains ", ", split using the comma and space delimiter.
        elsif str.include?(', ')
            str = str.split(', ')
        # If the string contains "=", split using the equal sign delimiter.
        elsif str.include?('=')
            str = str.split('=')
        # If none of the above delimiters are present, split the string using space as the delimiter.
        else
            str = str.split
        end

        # Iterates over each keyword in the str array and performs additional splitting and formatting if necessary.
        str.each do |keyword|
            if keyword.include?(', ')
                str[str.index(keyword)] = keyword.split(', ')
                next
            elsif keyword.is_a?(String) && keyword.count(',') > 1
                str[str.index(keyword)] = keyword.split(',')
            end
            str[str.index(keyword)] = keyword.split('=') if keyword.include?('=')
        end

        str.flatten! # Flattening the resulting array to remove any nested arrays.

        keywords = %w[SELECT UPDATE DELETE FROM WHERE]
        # Performing additional formatting on each keyword in the `str` array.
        str.each do |i|
            next if i.nil?

            # Removing trailing characters such as semicolon, closing parenthesis, and comma.
            i.delete_suffix!(';') if i[i.length - 1] == ';'
            i.delete_suffix!(')') if i[i.length - 1] == ')'
            i.delete_suffix!(',') if i[i.length - 1] == ','
            # Removing leading and trailing spaces from each keyword.
            i.lstrip! if i[0] == ' '
            i.rstrip! if i[-1] == ' '
            # Splitting the keyword into an array if it matches any of the predefined keywords.
            str[str.index(i)] = i.split if keywords.any? { |keyword| i.include?(keyword) }
            # Deleting the keyword if it becomes empty after formatting.
            str.delete(i) if i.empty?
        end

        str.flatten!

        result = []
        n = 0
        # Iterating over the `str` array and performing additional formatting and merging of elements.
        while n < str.length
            if str[n][0] == "'" && str[n][str[n].length - 1] != "'" && str[n].count("'") < 2
                # Handling single-quoted string values that span multiple elements.
                ary = [str[n]]
                while str[n][str[n].length - 1] != "'" && n < str.length
                    n += 1
                    ary << str[n] if n < str.length
                end
                # Joining the elements with comma or space based on initial string to maintain consistency.
                result << (initial_row.include?(ary.join(', ')) ? ary.join(', ') : ary.join(' '))
            else
                result << str[n]
            end
            n += 1
        end

        # Performing additional formatting on each element in the `result` array
        result.each_with_index do |element, index|
            # Removing leading and trailing spaces from each element.
            result[index] = element.lstrip! if element[0] == ' '
            result[index] = element.rstrip! if element[-1] == ' '
            # Removing single quotes from elements if present.
            result[index] = element.delete!("'") if element.include?("'")
            # Splitting the element into an array if it contains 'AND' keyword.
            result[index] = element.split(' AND ') if element.include?(' AND ')
        end

        result.flatten! # Flattening the resulting array to remove any nested arrays.
        result
    end
end


# rubocop:enable Metrics/BlockNesting, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Style/Documentation
