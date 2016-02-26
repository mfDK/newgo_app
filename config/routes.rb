Rails.application.routes.draw do
  devise_for :users
  # Using the devise gem sets up routes for new user creation
  # user sign_in and sessions as well. 
  root 'home#index'
end
