class HomeController < ApplicationController
  def index
  	@goals = Goal.where(user_id: current_user.id).reverse
  	# I want to see if this works or not

  	@test = "Hello I am Working"
  end
end
