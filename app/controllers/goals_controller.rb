class GoalsController < ApplicationController
  before_action :set_goal, only: [:show ]

  def index
  	@goals = Goal.where(user_id: current_user).reverse
  end

  def show
  	@tasks = @goal.tasks
    @now = Time.now.to_datetime
    @end_date = @goal.end_date

  	# This is creating a new array that will have all of the statuses of the user signed in
    @post_array = get_posts.map { |status| status['message'] }

  	# This is checking the post_array after all the statuses are push to see
  	# if the goal string is in the array.
  	@post_array_exist = @post_array.include? "My goal to #{@goal.title} was completed!"
    @fail_post_exist = @post_array.include? "I didn't hit my #{@goal.title} goal, I am a failure"

  	if @goal.completed_at.nil? && @post_array_exist == true
  		flash[:alert] = "1st Condition"
  	elsif @goal.completed_at.nil? == false && @post_array_exist == false && @now < @end_date
			begin
  			fb_post
  		rescue Koala::Facebook::APIError => exc
  			flash[:alert] = "Already posted"
  		end
  	end


    if @fail_post_exist == false && @goal.completed_at.nil? && @now > @end_date
      begin
        fail_post
      rescue Koala::Facebook::APIError => exc
        flash[:notice] = "Already posted"
      end
    elsif @post_array_exist == true && @goal.completed_at.nil? == false && @now > @end_date
      flash[:alert] = "Goal was a fail"
    end

  end

  def new
  	@goal = current_user.goals.new
  end

  def create
  	@goal = current_user.goals.build(goal_params)
  	if @goal.save
  		flash[:notice] = "#{current_user} has created a goal!"
  		redirect_to @goal
  	else
  		flash[:alert] = "Your goal was not created"
  	end
  end

  def edit
  	@goal = Goal.where(user_id: current_user, id: params[:id]).first
    # Through a form for, update an existing task that belong to the goal
    @goal_tasks = @goal.tasks
  end

  def update
  	@goal = Goal.where(user_id: current_user, id: params[:id]).first
  	@goal.update(goal_params)
  	@goal.save
  	redirect_to goal_path(@goal)
  end

  def destroy
  	@goal = Goal.where(user_id: current_user, id: params[:id]).first
  	@goal.destroy
  	redirect_to root_path
  end

  private 

  def set_goal
    @goal = Goal.find(params[:id])
  end

 	def goal_params
 		params.require(:goal).permit(:title,:description,:end_date,:completed)
 	end
end
