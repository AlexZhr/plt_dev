# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength, Metrics/CyclomaticComplexity, Metrics/ClassLength, Metrics/PerceivedComplexity, Metrics/AbcSize, Lint/MissingCopEnableDirective

require 'csv'
require 'json'

class MySqliteRequest
    # Initialize instance variables that take operations data to further processing
    def initialize
        @request_type = :none
        @select_columns = []
        @where_conditions = []
        @insert_data = {}
        @update_data = {}
        @delete_conditions = []
        @table_name = ''
        @order_column = ''
        @order_direction = nil
    end

    # Sets the table name and loads the table data from a CSV file.
    def from(table_name)
        @table_name = table_name
        @table = load_table
        self
    end

    # Sets the select columns for the query.
    def select(*column_name)
        if column_name.is_a?(Array)
            @select_columns += column_name.map(&:to_s)
        else
            @select_columns << column_name.to_s
        end
        set_request_type(:select)
        self
    end

    # Adds a WHERE condition to the query.
    def where(column_name, criteria)
        @where_conditions << [column_name, criteria]
        self
    end

    # Performs a join operation between two tables based on specified columns.
    def join(column_on_db_a, filename_db_b, column_on_db_b)
        db_b = CSV.table(filename_db_b)
        raise 'Both DBs must have headers.' unless @table.headers && db_b.headers

        # Create a hash for db_b for faster lookups
        db_b_hash = db_b.group_by { |row| row[column_on_db_b.downcase.to_sym] }
        result = []
        @table.each do |row_a|
            # for inner join, for left join replace 'next' with 'result << row_a.to_h'
            rows_b = db_b_hash[row_a[column_on_db_a.to_sym]]
            next if rows_b.nil?

            rows_b.each do |row_b|
                result << row_a.to_h.merge(row_b.to_h)
            end
        end

        headers = result.first&.keys
        csv_data = result.map { |row| CSV::Row.new(headers, row.values) }
        @table = CSV::Table.new(csv_data)
        self
    rescue StandardError => e
        # Handle errors and provide helpful information
        puts "Error joining tables: #{e.message}"
        self
    end

    # Sets the order column and order direction for the query.
    def order(order, column)
        @order_direction = order
        @order_column = column
        self
    end

    # Sets the request type to insert and loads the table data from a CSV file.
    def insert(table_name)
        set_request_type(:insert)
        @table_name = table_name
        @table = load_table
        self
    end

    # Sets the insert data for the query.
    def values(data)
        raise 'Request is not INSERT' unless @request_type == :insert

        @insert_data = data.transform_keys(&:to_s)

        self
    end

    # Sets the request type to update and loads the table data from a CSV file.
    def update(table_name)
        set_request_type(:update)
        @table_name = table_name
        @table = load_table
        self
    end

    # Sets the update data for the query.
    def set(data)
        @update_data = data
        self
    end

    # Sets the request type to delete.
    def delete
        set_request_type(:delete)
        self
    end

    # Executes the query based on the request type.
    def run
        case @request_type
        when :select
            do_select
        when :insert
            do_insert
        when :update
            do_update
        when :delete
            do_delete
        end
    end

    private

    # Sets the request type and ensures it is not changed after it has been set.
    def set_request_type(request)
        if @request_type == :none
            @request_type = request
        elsif @request_type == request
            # Request type is already set to the desired value, no action needed
        else
            raise "Request is already set #{@request_type} (try #{request})"
        end
    end

    # Performs the SELECT query and returns the result.
    def do_select
        result = @table.select { |row| match_conditions?(row) }
        @select_columns.keep_if { |header| @table.headers.include?(header.to_sym) }
        result = if @select_columns.empty? || @select_columns == ['*']
                     result.map(&:to_h)
                 else
                     result.map do |row|
                         selected_row = {}
                         @select_columns.each { |column| selected_row[column.to_sym] = row[column.to_sym] }
                         selected_row
                     end
                 end
        unless @order_column.empty?
            result = result.sort_by { |row| row[@order_column.to_sym] }
            result = result.reverse if @order_direction == :desc
        end
        print_result(result)
        result
    end

    # Performs the INSERT query and saves the updated table.
    def do_insert
        new_row = CSV::Row.new(@table.headers, [])
        @table.headers.each do |header|
            new_row[header.to_sym] = @insert_data.key?(header.to_s) ? @insert_data[header.to_s] : nil
        end
        @table << new_row
        save_table
    end

    # Performs the UPDATE query and saves the updated table.
    def do_update
        @table.each do |row|
            next unless match_conditions?(row)

            @update_data.each_pair { |column, value| row[column.to_sym] = value }
        end
        save_table
    end

    # Performs the DELETE query and saves the updated table.
    def do_delete
        @table.delete_if { |row| match_conditions?(row) }
        save_table
    end

    # Checks if a row matches the specified(WHERE) conditions.
    def match_conditions?(row)
        (@where_conditions.all? { |condition| row[condition[0].to_sym].to_s == condition[1].to_s })
    end

    # Prints the result of the query.
    def print_result(result)
        result.each { |row| puts row.values.join('|') }
    end

    # Loads the table data from a CSV file.
    def load_table
        unless File.exist?(@table_name)
            puts "Table file not found: #{@table_name}"
            return []
        end

        CSV.table(@table_name)
    rescue StandardError => e
        puts "Error loading table: #{e.message}"
        []
    end

    # Saves the updated table to a CSV file.
    def save_table
        File.write(@table_name, @table.to_csv)
    rescue StandardError => e
        puts "Error saving table: #{e.message}"
    end
end

# def main
# # Questiom 0 of 10
# request = MySqliteRequest.new
# request = request.from('nba_player_data_lite.csv')
# request = request.select('*')
# request.run
# # #Questions 1 of 10
# request = MySqliteRequest.new
# request = request.from('nba_player_data_lite.csv')
# request = request.select('name','height','year_start')
# request = request.where('college', 'Iowa State University')
# request.run
# # Question 2 of 10
# request = MySqliteRequest.new
# request = request.from('nba_player_data_lite.csv')
# request = request.select('name', 'year_end')
# request = request.where('college', 'University of California')
# request = request.where('year_start', '1997')
# request.run
# #Question 3 of 10
# request = MySqliteRequest.new
# request = request.insert('nba_player_data_lite.csv')
# request = request.values({ 'name' => 'Don Adams', 'year_start' => '1971', 'year_end' => '1977', 'position' => 'F',
#                            'height' => '6-6', 'weight' => '210', 'birth_date' => 'November 27, 1947', 'college' =>
#                              'Northwestern University' })
# request.run
# # Question 4 of 10
# request = MySqliteRequest.new
# request = request.update('nba_player_data_lite.csv')
# request = request.set({'name' => 'Don Adams'})
# request = request.where('name', 'Don DinDon')
# request.run
# Question 5 of 10
# request = MySqliteRequest.new
# request = request.delete.from('nba_player_data_lite.csv').where('name', 'Don DinDon').run
# #Questions 6 of 10
# request = MySqliteRequest.new
# request = request.from('nba_player_data_lite.csv')
# request = request.join('name', 'players_lite.csv', 'Player')
# request = request.order(:desc, 'year_start')
# request = request.select('name', 'born', 'college', 'year_start')
# request.run
# end

# main
