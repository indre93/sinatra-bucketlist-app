class UsersController < ApplicationController
 
  # The purpose of this route is to render the login page (form)
  get '/login' do 
    erb :login
  end

  # The purpose of this route is to render the signup page (form)
  get '/signup' do 
  
  end

end