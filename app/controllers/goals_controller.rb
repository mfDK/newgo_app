class GoalsController < ApplicationController
  def index
  	@goals = Goal.where(user_id: current_user)
  end

  def show
  	@goal = Goal.where(user_id: current_user, id: params[:id]).first
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
 		params.require(:goal).permit(:title,:description,:end_date)
 	end
end
