class UsersController < ApplicationController
 
  # this route is to render the login page (form)
  get '/login' do 
    erb :login
  end

  # this is to receive the login form, find the user and log the user in (create a session)
  post '/login' do 
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
    # log the user in - create the user session
      session[:user_id] = @user.id # actually logging the user in
      flash[:messages] = "Welcome back #{@user.name}!"
      redirect "users/#{@user.id}"
    else
      flash[:errors] = "Invalid credentials. Please try again or sign up."
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
    @user = User.new(params)
    
    if @user.save
      session[:user_id] = @user.id # actually logging the user in 
      flash[:messages] = "Account successfully created. Welcome to the BucketList App, #{@user.name}!"    
      redirect "/users/#{@user.id}"
    else
      flash[:errors] = "Account creation failure: #{@user.errors.full_messages.to_sentence}"
      redirect '/signup'
    end
  end

  # user SHOW route
  get '/users/:id' do
    @user = User.find_by(id: params[:id])
    redirect_if_not_logged_in
    erb :'/users/show'
  end

  get '/logout' do
    redirect_if_not_logged_in
    session.clear
    flash[:messages] = "You have successfully logged out!"
    redirect '/login'
  end


end