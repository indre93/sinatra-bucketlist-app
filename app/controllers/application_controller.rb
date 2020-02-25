require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "private_bucket_list"
  end

  get "/" do
    erb :welcome
  end

  helpers do 

    def logged_in?
      # true if user logged in, otherwise fale
      !!current_user 
    end

    def current_user
      # this instance variable will be created and assigned if user found, otherwise it will still be nill
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

end
