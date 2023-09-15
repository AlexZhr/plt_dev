# Welcome to Ruby Quest06
***

## Task
There were 3 chalenges: 1st was to write a method that "parse" a string in cvs format. Second was to create a programm that transform data about coffeeshop clients from string in csv format to new array with classified values against cheched items and 3rd was to process that data and return total data of some positions of clients data.

## Description
I've written my parser by using method array.split() 2 times, 1st for split lines and 2nd to separate columns values. (my_data_transform, my data transform) - firstly I've split the csc format string to lines(rows) and columns values(2d array), then I wrote methods that compare filter data of defined columns(according to task requirements) and transform return value in a required format in a new array. Afterwards, array.join elements of 2d array to asking array with strings. And the for 3rd I've written the program with process resulting data of previous quest. At the start I've split first item of array to get headers of columns and split other "lines" for values in columns to the new array. Second step was to create loop which use values of headers(as keys of hash) to method that create arrays of column values and return hash with included count of occurrences strings(as keys) of asked column.

## Installation
Project doesn't need to be installed.

## Usage
It work with tests of the DoCode(gandalf terminal command - it's sending data as arguments for test and check returned values).
```
./my_project argument1 argument2
```

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
