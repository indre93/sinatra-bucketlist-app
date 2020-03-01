class GoalsController < ApplicationController

  # this is to render a form to create a new goal
  get '/goals/new' do
    erb :'/goals/new'
  end

  # this route to create a new goal & save it to the DB
  post '/goals' do 
    if !logged_in?
      redirect '/'
    end
    # Only want to save it if it has some content
    if params[:title] != "" && params[:description] != ""
      @goal = Goal.create(title: params[:title], description: params[:description], user_id: current_user.id)
      redirect "goals/#{@goal.id}"
    else
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
      if @goal.user == current_user
        erb :'/goals/edit'
      else
        redirect "users/#{current_user.id}"
      end
    else 
      redirect '/'
    end
  end


  patch '/goals/:id' do 
    set_goal 
    if logged_in?
      if @goal.user == current_user
        @goal.update(title: params[:title], description: params[:description])
        redirect "/goals/#{@goal.id}"
      else
        redirect "users/#{current_user.id}"
      end
    else
      redirect '/'
    end
  end

  # index route to show all goals

  private # it means we're going to create methods that will only be used by this class
  
  def set_goal 
    @goal = Goal.find_by(params[:id])
  end

end