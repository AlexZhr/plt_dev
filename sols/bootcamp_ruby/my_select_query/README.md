# Welcome to My Select Query
***

## Task
Create a class MySelectQuery with funtion that will receive a CSV content (as a string), first line will be the name of the column. And implement a where() method which will take 2 arguments: column_name and value and return an array of strings which matches the value.

## Description
I've create the class MySelectQuery >> declared initialize() method(new nethod with parameters) that receive csv_content (string headers + rows). Then I've declared instance variable @data that receive parsed csv_content(rows with 'values' in the hash format that have headers as 'keys'). Afterwards, in the implemention where() method I've wrote a function that using method each() to find accepted search criteria and accept the header as the search key and then I've joined values to string using method map() and join().

## Installation
The project doesn't need to be installed.

## Usage
It works with receiving csv_content string, column name and seached critia as parameters.
```
./my_project argument1 argument2
```

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
