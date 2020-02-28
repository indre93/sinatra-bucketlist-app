require 'pry'

class UsersController < ApplicationController
 
  # The purpose of this route is to render the login page (form)
  get '/login' do 
    erb :login
  end

  # The purpose of this route is to receive the login form, find the user and log the user in (create a session)
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
    end
  end

  # this route's job is to render the signup page
  get '/signup' do
    erb :signup
  end

  # this is where we will create the new user and persist the new user to the database
  post '/users' do
    # I only want to persist a user that has a name, email & password
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
      # valid input
      @user = User.create(params)
    else
      # not valid input
    end
  end

  # user SHOW route
  get '/users/:id' do
    "this will be the user show route"
  end


end