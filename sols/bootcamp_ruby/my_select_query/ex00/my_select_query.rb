require 'csv'

class MySelectQuery
    def initialize(csv_content)
        @data = CSV.parse(csv_content, headers: true)        
    end 

    def where(column_name, criteria)
        result_csv = []
        @data.each do |row|
            if row[column_name] == criteria
                result_csv << row.map{|k, v| "#{v}"}.join(',')
            end
        end
        return result_csv
    end
end
