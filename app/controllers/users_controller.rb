require 'pry'

class UsersController < ApplicationController
 
  # this route is to render the login page (form)
  get '/login' do 
    erb :login
  end

  # this is to receive the login form, find the user and log the user in (create a session)
  post '/login' do 
    # find the user
    @user = User.find_by(email: params[:email])
    # authenticate the user (verified the user is who they say they are - have the right credentials)
    if @user.authenticate(params[:password])
    # log the user in - create the user session
      session[:user_id] = @user.id #actually logging the user in
    # redirect the user's landing page (user show page)
      puts session
      redirect "users/#{@user.id}"
    else
      # tell the user the have entered the invalid credential
      # redirect them to the login page
      redirect '/login'
    end
  end

  # this route's job is to render the signup page
  get '/signup' do
    erb :signup
  end

  # this is where new user is created and persisted to the DB
  post '/users' do
    # I only want to persist a user that has a name, email & password
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
      # valid input
      @user = User.create(params)
      session[:user_id] = @user.id # actually logging the user in      
      # redirect to user's sow page
      redirect "/users/#{@user.id}"
    else
      # not valid input
      # better to include an error message
      redirect '/signup'
    end
  end

  # user SHOW route
  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end


end