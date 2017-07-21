class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # This method makes sure that a user is signed in before any actions can be
  # created or viewed
  # before_action :authenticate_user!

  # helper_method :fb_post
  # helper_method :get_posts
  # helper_method :fail_post
  # helper_method :days_until
  # helper_method :my_pic
  # helper_method :fb_user_object
  #
  # def my_pic
  #   @graph_pic = Koala::Facebook::API.new(session[:fb_session_token])
  #   @picture = @graph_pic.get_picture("me")
  # end
  #
  # def fb_user_object
  #   @graph = Koala::Facebook::API.new(session[:fb_session_token])
  #   @user_object = @graph.get_object("me")
  # end
  #
  # def get_posts
  #   @graph = Koala::Facebook::API.new(session[:fb_session_token])
  #   @graph.get_connections("me","feed")
  # end
  #
  # def fb_post
  # 	@graph = Koala::Facebook::API.new(session[:fb_session_token])
  # 	@profile = @graph.get_object("me")
  # 	@graph.put_connections("me","feed",message:"My goal to #{@goal.title} was completed!")
  # end
  #
  # def fail_post
  #   @graph = Koala::Facebook::API.new(session[:fb_session_token])
  #   @profile = @graph.get_object("me")
  #   @graph.put_connections("me","feed",message:"I didn't hit my #{@goal.title} goal, I am a failure")
  # end

  after_filter :store_action

  def store_action
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      store_location_for(:user, dashboard_path)
    end
  end

end
