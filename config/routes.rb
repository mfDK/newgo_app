Rails.application.routes.draw do

	root 'home#index'
	
  devise_for :users , :controllers => { :omniauth_callbacks => "callbacks" }
  # this controller is set for the devise users because it is being used
  # for the facebook api through the callbacks_controller
  # Using the devise gem sets up routes for new user creation
  # user sign_in and sessions as well. 

  resources :goals do
    resources :tasks
  end

end
