# frozen_string_literal: true

# rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/BlockLength, Style/Documentation, Metrics/ClassLength

require 'readline'
require 'csv'
require_relative 'my_sqlite_request'
require_relative 'my_sqlite_methods'

class MySqlite
    include CLImethods
    def run!
        stty_save = 'stty -g'.chomp
        puts 'MySQLite version 0.1 2022-04-07'
        begin
            while buf = Readline.readline('my_sqlite_cli>', true) # rubocop:disable Lint/AssignmentInCondition
                request = MySqliteRequest.new
                request_main = nil
                keyword = ''
                table = ''
                table_joined = ''
                select_columns = []
                join_on_columns = []
                where_conditions_arr = []
                insert_conditions_key = []
                update_conditions_arr = []
                val_array = []
                order_dir = :none
                order_col = ''
                break if buf.downcase.strip == 'quit' # Check for the quit command

                parser(buf).each do |command| # Identify the main SQL keyword (SELECT, INSERT, UPDATE, DELETE)
                    # Identify the main SQL keyword (SELECT, INSERT, UPDATE, DELETE)
                    if %w[SELECT INSERT UPDATE DELETE].include?(command)
                        keyword = command.upcase
                        request_main = keyword.downcase.to_sym
                        next
                    elsif %w[INTO FROM WHERE SET VALUES JOIN ON ORDER].include?(command)
                        keyword = command.upcase
                        next
                    elsif %w[INNER BY].include?(command)
                        next
                    end

                    case keyword.upcase # Process different parts of the SQL query based on the keyword
                    when 'SELECT'
                        select_columns << command
                        next
                    when 'ORDER'
                        order_col = command if order_col.empty?
                        order_dir = command.downcase.to_sym if %w[ASC DESC].include?(command)
                        next
                    when 'INTO', 'UPDATE', 'FROM'
                        if table.empty?
                            table = command
                            next
                        elsif request_main == :insert && !table.empty? && !%w[WHERE VALUES].include?(command)
                            insert_conditions_key << command
                            next
                        end
                    when 'JOIN'
                        table_joined = command
                    when 'ON'
                        join_on_columns << command
                    when 'WHERE'
                        where_conditions_arr << command
                        next
                    when 'SET'
                        update_conditions_arr << command
                        next
                    when 'VALUES'
                        val_array << command
                        next
                    end
                end

                # Build the MySqliteRequest object based on the parsed SQL query
                case request_main 
                when :select, :delete
                    request.from(table)
                    request.select(*select_columns) unless select_columns.empty?
                    request.delete if request_main == :delete && !where_conditions_arr.empty?
                    unless join_on_columns.empty?
                        join_on_columns.collect! { |element| element.split('.').last }
                        request.join(join_on_columns.first, table_joined, join_on_columns.last)
                    end
                    request.order(order_dir, order_col) unless (order_dir && order_col).empty?
                when :insert
                    request.insert(table)
                    if insert_conditions_key.empty?
                        headers = CSV.open(request.instance_variable_get(:@table_name), &:readline)
                        insert_data_hash = Hash[headers.zip(val_array)].delete_if { |_k, v| v.nil? }
                        request.values(insert_data_hash)
                    elsif insert_conditions_key.length == val_array.length
                        combined_hash = insert_conditions_key.empty? ? Hash[*val_array] : Hash[insert_conditions_key.zip(val_array)]
                        request.values(combined_hash)
                    end
                when :update
                    request.update(table)
                    request.set(Hash[*update_conditions_arr])
                end
                unless where_conditions_arr.empty?
                    if where_conditions_arr.length <= 2
                        request.where(*where_conditions_arr)
                    else
                        where_conditions = where_conditions_arr.each_slice(2).to_a
                        where_conditions.each { |column, value| request.where(column, value) }
                    end
                end
                request.run
            end
        rescue Interrupt
            system('stty', stty_save)
            exit
        end
        system('stty', stty_save)
    end
end

n_req = MySqlite.new
n_req.run!

# rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity, Metrics/BlockLength, Style/Documentation, Metrics/ClassLength
