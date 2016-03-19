class GoalsController < ApplicationController
  def index
  	@goals = Goal.where(user_id: current_user)
  end

  def show
  	@goal = Goal.where(user_id: current_user, id: params[:id]).first
  	@goal_tasks = @goal.tasks

    # This is where the AJAX request will happen
      respond_to do |format|
        format.html {}
        format.js {}
      end

  	# Get the count of how many tasks a certain goal has
  	@num_tasks = @goal_tasks.length

  	# get the count of how many tasks are completed for the goal
  	@complete_tasks = @goal_tasks.where(completed:true).length

  	# Gets the number of tasks left
  	@left_tasks = @num_tasks - @complete_tasks

  	## This is iterate through each goals tasks and the .all? method will
  	## check just the completed attribute to check if they are all true.
  	@com_task = Array.new
  	# This creates an empty array 
  	@goal_tasks.each do |task|
  		@com_task.push(task.completed)
  		# through each iteration of tasks in the goal, the completed
  		# attribute is pushed to the @com_task array
  		if @com_task.all?
  			# This will check if the @com_task array has all true values meaning
  			# all the tasks of the specific goal are completed. If so then the 
  			# completed attribute of the GOAL will be set to true. 
  			@goal.update(completed: true)
  			@goal.save
  		else
  			@goal.update(completed: false)
  			@goal.save
  		end
  	end

  	# This is creating a new array that will have all of the statuses of the user signed in
  	# the each method pushed the message as a string into the array
  	@post_array = Array.new
  	get_posts.each do |post|
  		@post_array.push(post['message'])
  	end

  	# This is checking the post_array after all the statuses are push to see
  	# if the goal string is in the array.
  	@post_array_exist = @post_array.include? "My goal to #{@goal.title} was completed!"
    @fail_post_exist = @post_array.include? "I didn't hit my #{@goal.title} goal, I am a failure"

  	# goal is created --> goal.completed is false
  		# no fb status
  	# goal tasks are created
  		# no fb status
  		# no goal.completed is still false
  	# when all tasks are completed --> goal.complted true
  		# create facebook status

  	if @goal.completed == true && @post_array_exist == true
  		flash[:alert] = "1st Condition"
  	elsif @goal.completed == true 
			begin
  			fb_post
  		rescue Koala::Facebook::APIError => exc
  			flash[:alert] = "Already posted"
  		end
  	end

    @now = Time.now.to_datetime
    @end_date = @goal.end_date
    if @fail_post_exist == false && @goal.completed == false && @now > @end_date
      begin
        fail_post
      rescue Koala::Facebook::APIError => exc
        flash[:notice] = "Already posted"
      end
    elsif @post_array_exist == true && @goal.completed == false && @now > @end_date
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

 	def goal_params
 		params.require(:goal).permit(:title,:description,:end_date,:completed)
 	end
end
