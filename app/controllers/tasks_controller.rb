class TasksController < ApplicationController
  def index
  	@goal = Goal.find(params[:goal_id])
  	@tasks = @goal.tasks
  end

  def show
  	@goal = Goal.find(params[:goal_id])
  	@task = @goal.tasks.find(params[:id])
  end

  def new
  	@goal = Goal.find(params[:goal_id])
  	@task = @goal.tasks.new
  end

  def create
  	@goal = Goal.find(params[:goal_id])
  	@task = @goal.tasks.new(task_params)
  	if @task.save
  		flash[:notice] = "Your task has been created"
  		redirect_to goal_task_path(@goal)
  	else
  		flash[:alert] = "Your Task has not been created"
  		redirect_to new_goal_task_path
  	end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def task_params
  	params.require(:task).permit(:goal_id,:title,:description,:end_date,:completed)
  end
end
