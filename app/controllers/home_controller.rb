class HomeController < ApplicationController
  def index
  	@goals = Goal.where(user_id: current_user.id).reverse
  	# I want to see if this works or not

  	@test = "Hello I am Working"
  	@test_branch = "I am the test branch"
  end
end
