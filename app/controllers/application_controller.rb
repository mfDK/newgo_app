class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # This method makes sure that a user is signed in before any actions can be
  # created or viewed 
  before_action :authenticate_user!

end
