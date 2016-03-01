class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # This method makes sure that a user is signed in before any actions can be
  # created or viewed 
  before_action :authenticate_user!

  helper_method :fb_post
  helper_method :get_posts
  helper_method :fail_post
  # helper_method :days_until

  def get_posts
    @graph = Koala::Facebook::API.new(session[:fb_session_token])
    @graph.get_connections("me","feed")
  end

  def fb_post
  	@graph = Koala::Facebook::API.new(session[:fb_session_token])
  	@profile = @graph.get_object("me")
  	@graph.put_connections("me","feed",message:"My #{@goal.title} was completed!")
  end

  def fail_post
    @graph = Koala::Facebook::API.new(session[:fb_session_token])
    @profile = @graph.get_object("me")
    @graph.put_connections("me","feed",message:"I didn't hit my #{@goal.title} goal, I am a failure")
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
