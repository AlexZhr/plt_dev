# Welcome to My Sqlite
***

## Task
The problem this project aims to solve is the need for a simplified SQLite-like database with a command-line interface (CLI). The challenge lies in implementing the necessary functionality to support SQL-like commands and data manipulation operations.

## Description
This project provides a solution by implementing a basic CLI for a MySqlite database. The CLI allows users to interact with the database by entering SQL-like commands to perform operations such as SELECT, INSERT, UPDATE, DELETE, JOIN, and ORDER. It supports table operations, data selection, data filtering, data manipulation, joining tables, and sorting data.

## Installation
To install the project, follow these steps:

1. Clone the repository: git clone https://git.us.qwasar.io/my_sqlite_128667_nnyfjz/my_sqlite.git
2. Change to the project directory: cd my_sqlite
3. Install dependencies: bundle install

## Usage
To run the MySqlite CLI, execute the provided Ruby script(my_sqlite_cli.rb) from the command line.
Once the CLI is running, you can enter commands in the following format:
my_sqlite_cli> [command]
Replace argument1 and argument2 with the required arguments for your specific use case. Once the CLI is running, you can enter SQL-like commands to interact with the database. End each command with a semicolon (;).

Here are some examples:
- SELECT * FROM db.csv;
- SELECT column1, column2 FROM db.csv WHERE columnN = valueN ORDER BY column ASC|DESC;
- SELECT column1, column2 FROM db1.csv JOIN db1.csv ON db1.csv.column1 = db1.csv.column2 WHERE columnN = valueN ORDER BY column1 DESC;
- INSERT INTO db.csv VALUES (value1, value2, ..., valueN); <!-- Count and order of values should match corresponding to the tabular one in this case -->
- INSERT INTO db.csv (column1, column2) VALUES (value1, value2); <!-- order of columns and values should correspond each other this case -->
- UPDATE db.csv SET column1 = value1 WHERE columnN = valueN;
- DELETE FROM db.csv WHERE columnN = valueN;
```
./my_project argument1 argument2
```

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
