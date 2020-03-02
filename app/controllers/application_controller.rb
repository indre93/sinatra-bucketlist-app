require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "private_bucket_list"
    register Sinatra::Flash
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
      !!current_user
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def authorized_to_edit?(goal)
      goal.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "Sorry! you must be logged in to view this page. Please log in or sign up."
        redirect '/'
      end
    end
  end

end
