class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  	@my_profile_pic = my_pic
  	@my_user = fb_user_object
  end
end
