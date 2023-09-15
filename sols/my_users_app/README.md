# Welcome to My Users App
***

## Task
In the project was needed to create and implement architecture  MVC(Model View Controller) as user application. It must be done in the model(my_user_model.rb) that should include the CRUD(create, read, update, delete) user functions and works with SQL(sqlite3) data table for storing users data(sqlite3). Then write app.rb controller for user model(routes that allow to use model fuction in web). And create renedering views as web interface of the project.

## Description
In the file my_user_model.rb I was writen the class User, and firstly wrote attr_accessor that gives acces to reading/writing user attributes(firstname, lastname, age, email, password, id) and created the methods:
-- initialize - Initialize instance variables and refer it to class attributes for opportunity to works with them in the next methods;
-- connectdb - Define method that provide connection to database and CREATE TABLE IF NOT EXISTS a sql table, also it's handle for db errors;
-- create - Method that create new users insireting data of user to sql table;
-- find - The find method fetch a row by id criteria and return fetch user info;
-- all - The all method fetch and return data of all users without passwords;
-- update - The update method searching a user by user_id in the database and update a value of an attribute;
-- destroy - The destroy method delete a user from the db by id;
-- authenticate - The authenticate method search for user by email and password. It returns users data if user authentication succes.
Afterwards I write app.rb controller for model that contains routes that process requests with information using methods of the User class:
-- get '/' do - the route that display data of all users from db(data base) with method User.all and display it in the view index.erb;
-- post '/users' do - create a new user in db using methods User.create and user find. Also it has authenticate function in case if firstname is empty;
-- post '/sign_in' do - singed in user with authenticate method making request with email and password;
-- put '/users' do - update password of a user if user is singed in(session is true);
-- delete '/sign_out' do - clear the session;
-- delete '/users' do - delete a user from db user if session is active.


## Installation
Project works with ruby web-browser.

## Usage
Run app.rb, then use curl web-browser with host adress to work with application controller or another web browser to go to use functionality of the app interface view.
```
./my_project argument1 argument2
```

### The Core Team


<span><i>Made at <a href='https://qwasar.io'>Qwasar SV -- Software Engineering School</a></i></span>
<span><img alt='Qwasar SV -- Software Engineering School's Logo' src='https://storage.googleapis.com/qwasar-public/qwasar-logo_50x50.png' width='20px'></span>
