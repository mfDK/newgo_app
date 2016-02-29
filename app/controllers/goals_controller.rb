class GoalsController < ApplicationController
  def index
  	@goals = Goal.where(user_id: current_user)
  end

  def show
  	@goal = Goal.where(user_id: current_user, id: params[:id]).first
  	@goal_tasks = @goal.tasks

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
  	
  	## This problem with this logic is that when a new goal is created
  	## the main goal is automatically considered completed because there
  	## are no tasks
  	# if @left_tasks == 0
  	# 	@goal.update(completed: true)
  	# 	@goal.save
  	# elsif @left_tasks > 0
  	# 	@goal.update(completed: false)
  	# 	@goal.save
  	# end
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
