require 'sinatra'
require './my_user_model.rb'
require 'json'

enable :sessions

 set('views', './views')

set :bind, '0.0.0.0'
set :port, 8080

get '/' do 
    @users = User.all
    erb :index
end


get '/users' do
    User.all.map{|row| row.slice(:id, :firstname, :lastname, :age, :email)}.to_json
end

post '/users' do
    if params[:firstname]
        user_create = User.create(params)
        "user created"
        new_user = User.find(user_create.id)
        user={:firstname=>new_user.firstname,:lastname=>new_user.lastname,:age=>new_user.age,:email=>new_user.email}.to_json
    else
        inspected_user = User.authenticate(params[:email], params[:password])
        if inspected_user != nil
            status 200
            session[:user_id] = inspected_user.id
        else
            status 401
        end
        inspected_user.to_json
    end    
end

# POST route for user sign in
post '/sign_in' do
    user=User.authenticate(params[:email], params[:password])
    if user && user.id
        session[:user_id] = user.id
        status 200
        "signed in"
    else
        status 401
    end
    user.to_json
end

def signed_in?
    session[:user_id] != 0
end

put '/users' do
    if signed_in?
        User.update(session[:user_id], 'password', params[:password])
        new_user = User.find(session[:user_id])
        status 200
        user = {:firstname=>new_user.firstname,:lastname=>new_user.lastname,:age=>new_user.age,:email=>new_user.email}.to_json
    else
        status 401
    end
end

delete '/sign_out' do
    session.clear if session[:session_id]
    status 204
end

delete '/users' do
    if !signed_in?
        status 401
        body "User not signed in"
    else
        #User.destroy(session[:user_id]) 
        #session.clear
        status 204
    end
end

