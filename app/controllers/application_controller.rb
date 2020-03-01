require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "private_bucket_list"
  end

  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end
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

    def authorized_to_changes?(goal)
      goal.user == current_user
    end
  end

end
