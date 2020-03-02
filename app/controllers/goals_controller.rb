class GoalsController < ApplicationController

  # route to show all goals
  get '/goals' do
    if logged_in?
      @goals = Goal.all 
      erb :'goals/index'
    else
      flash[:errors] = "You must be logged in to view this page. Please log in or sign up."
      redirect '/'
    end
  end

  # route is to render a form to create a new goal
  get '/goals/new' do
    if logged_in?
      erb :'/goals/new'
    else
      flash[:errors] = "You must be logged in to create a goal. Please log in or sign up."
      redirect '/'
    end
  end

  # route to create a new goal & save it to the DB
  post '/goals' do 
    # Only want to save it if it has some content
    if params[:title] != "" && params[:description] != ""
      @goal = Goal.create(title: params[:title], description: params[:description], user_id: current_user.id)
      flash[:messages] = "Goal has been successfully created!"
      redirect "/goals/#{@goal.id}"
    else
      flash[:errors] = "Unable to save goal. Please make sure all fields are filled in and try again."
      redirect '/goals/new'
    end
  end

  # show route for a goal
  get '/goals/:id' do
    set_goal 
    erb :'/goals/show'
  end

  # route to edit a goal - should send us to goal/edit.erb & render edit form
  get '/goals/:id/edit' do
    set_goal 
    if logged_in?
      if authorized_to_edit?(@goal)
        erb :'/goals/edit'
      else
        flash[:errors] = "Sorry! you cannot make changes to other people's goals."
        redirect "users/#{current_user.id}"
      end
    else 
      flash[:errors] = "Sorry! you must be logged in to view this page. Please log in or sign up"
      redirect '/'
    end
  end


  patch '/goals/:id' do 
    set_goal 
    if logged_in?
      if authorized_to_edit?(@goal) && params[:title] != "" && params[:description] != ""
        @goal.update(title: params[:title], description: params[:description])
        flash[:messages] = "Changes have successfully been made!"
        redirect "/goals/#{@goal.id}"
      else
        flash[:errors] = "Sorry! you cannot make changes to other people's goals."
        redirect "/users/#{current_user.id}"
      end
    else
      flash[:errors] = "Sorry! you must be logged in to view this page. Please log in or sign up"
      redirect '/'
    end
  end

  delete '/goals/:id' do
    set_goal
    if authorized_to_edit?(@goal)
      @goal.destroy
      flash[:messages] = "Goal has been deleted."
      redirect '/goals'
    else
      flash[:errors] = "Sorry! you cannot make changes to other people's goals."
      redirect '/goals'
    end
  end

  private # it means we're going to create methods that will only be used by this class
  
  def set_goal 
    @goal = Goal.find(params[:id])
  end

end