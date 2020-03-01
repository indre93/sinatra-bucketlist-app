class GoalsController < ApplicationController

  # this is to render a form to create a new goal
  get '/goals/new' do
    erb :'/goals/new'
  end

  # this route to create a new goal & save it to the DB
  post '/goals' do 
    # Only want to create if user logged in
    if !logged_in?
      redirect '/'
    end

    # Only want to save it if it has some content
    if params[:title] != "" && params[:description] != ""
      @goal = Goal.create(title: params[:title], description: params[:description], user_id: current_user.id)
      redirect "/goals/#{@goal.id}"
    else
      redirect '/goals/new'
    end
  end

  # show route for a goal
  get '/goals/:id' do
    @goal = Goal.find_by(params[:id])
    erb :'/goals/show'
  end

  # route to edit a goal - should send us to goal/edit.erb
  # render an edit form
  get '/goals/:id/edit' do
    erb :'/goals/edit'
  end

  # index route to show all goals

end