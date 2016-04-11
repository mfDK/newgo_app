class TasksController < ApplicationController
  def index
  	@goal = Goal.find(params[:goal_id])
  	@tasks = @goal.tasks
  end

  def show
  	@goal = Goal.find(params[:goal_id])
  	@task = @goal.tasks.find(params[:id])
  end

  def complete
    @task = Task.find(params[:id])
    @task.update_attribute(:completed_at, Time.zone.now)
    respond_to do |format|
      format.html
      format.js
    end
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
  		redirect_to @goal
  	else
  		flash[:alert] = "Your Task has not been created"
  		redirect_to new_goal_task_path
  	end
  end

  def edit
  	@goal = Goal.find(params[:goal_id])
  	@task = @goal.tasks.find(params[:id])
  end

  def update
  	@goal = Goal.find(params[:goal_id])
  	@task = @goal.tasks.find(params[:id])
  	@task.update(task_params)
  	@task.save
    redirect_to @goal
  end

  def destroy
  	@goal = Goal.find(params[:goal_id])
  	@task = @goal.tasks.find(params[:id])
  	@task.destroy
  	redirect_to goal_path(@goal)
  end

  private
  def task_params
  	params.require(:task).permit(:goal_id,:title,:description,:end_date,:completed)
  end
end
