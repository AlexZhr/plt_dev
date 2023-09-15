require 'sqlite3'

class User         
    attr_accessor :id, :firstname, :lastname, :age, :email, :password
    
    def initialize(firstname, lastname, age, email, password, id=0)
        @id = id
        @firstname = firstname
        @lastname = lastname
        @age = age
        @email = email
        @password = password 
    end
    
    # Define method that provide connection to database and CREATE TABLE IF NOT EXISTS a sql table, also it's handle for db errors
    def self.connectdb
        begin  
            if @db
                @db = SQLite3::Database.open 'db.sql'
            else
                @db = SQLite3::Database.new 'db.sql' 
            end
            @db.results_as_hash = true
            @db.execute "CREATE TABLE IF NOT EXISTS users(
                    Id INTEGER PRIMARY KEY, 
                    firstname STRING, 
                    lastname STRING, 
                    age INT,
                    email STRING,
                    password STRING                   
                )"
                return @db
            rescue SQLite3::Exception => e  
                puts "Exception occurred"
                puts e
        end
    end
# Method that create new users insireting data of user to sql table
    def self.create(user_info)
        @db = self.connectdb
        @db.execute "INSERT INTO users (firstname, lastname, age, email, password) VALUES (?, ?, ?, ?, ?)",
            user_info[:firstname], 
            user_info[:lastname], 
            user_info[:age], 
            user_info[:email],
            user_info[:password]
        
        user = User.new(user_info[:firstname], user_info[:lastname], user_info[:age], user_info[:email], '')
        user.id = @db.last_insert_row_id
        @db.close
        return user
    end

# The find method fetch a row by id criteria and return fetch user info, also it deletes password for confidentiality
    def self.find(user_id)
        @db = self.connectdb
        results = @db.execute("SELECT * FROM users WHERE id=?", user_id).first   
        user = User.new(results["firstname"], results["lastname"], results["age"], results["email"], results["password"])
        @db.close 
        return user
    end
# The all method fetch and return data of all users without passwords
    def self.all
        @db = self.connectdb
        users_all = @db.execute ("SELECT id, firstname, lastname, age, email FROM users")
        @db.close
        return users_all
    end
# The update method searching a user by user_id in the database and update a value of an attribute
    def self.update(user_id, attribute, value)
        @db = self.connectdb
        @db.execute "UPDATE users SET #{attribute.to_s}=? WHERE id=?", value, user_id
        results = @db.execute"SELECT * FROM users WHERE id=?", user_id
        @db.close
        return results
    end

# The destroy method delete a user from the db by id
    def self.destroy(user_id)
        @db = self.connectdb
        @db.execute"DELETE FROM users WHERE Id=?", user_id
        @db.close
    end

    # The authenticate method search for user by email and password. It returns users data if user authentication succes
    def self.authenticate(email, password)
        @db = self.connectdb
        results = @db.execute("SELECT * FROM users WHERE email=? AND password=?", email, password).first
        if results
            user = User.new(results["firstname"], results["lastname"], results["age"], results["email"], results["password"], results["Id"])
        else
            user = nil
        end
        @db.close
        return user
    end
end 


