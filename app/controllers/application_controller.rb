class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # This method makes sure that a user is signed in before any actions can be
  # created or viewed 
  before_action :authenticate_user!

  helper_method :fb_post
  helper_method :days_until

  def fb_post
  	@graph = Koala::Facebook::API.new(session[:fb_session_token])
  	@profile = @graph.get_object("me")
  	@graph.put_connections("me","feed",message:"I posted mang")
  end

  # def days_until
  # 	@goal = Goal.find(params[:id])
  # 	@goal_date = @goal.end_date
  # 	@gol_date = @goal_date.strftime("%m/%d/%Y")
  # 	@now = Time.now.strftime("%m/%d/%Y")

  # 	if @gol_date == @now
  # 		flash[:notice] = "End date"
  # 	else
  # 		flash[:alert] = "Nah son"
  # 	end

  # end
end
