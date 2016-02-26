class CallbacksController < Devise::OmniauthCallbacksController

	# this method is used for the facebook api for logins
	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])
		# when a user successfully signs in, he is given a omniauth 
		# authentication hash. The @user instance variable finds
		# this user through the signin request and sets it to the 
		# @user instance variable

		if @user.persisted?
			# The persisted? method returns true if the record is persisted
			# to the database. ** its not a new record and it was not destroyed

			sign_in_and_redirect @user , :event => :authentication 
			# sign_in_and_redirect is a devise method given that signs in a user
			# and redirects them to the authentication event

			set_flash_message(:notice,:success,:kind => "Facebook") if is_navigational_format?

			# This gets the omniauth token from the @user instance variable
			# and sets it to a session that the user is in after sign_in
			@auth = request.env["omniauth.auth"]
  		@token = @auth['credentials']['token']
  		session[:fb_session_token] = @token
		else
			session["devise.facebook_data"] = request.env["omniauth.auth"]
			redirect_to new_user_registration_url
		end
	end

	def failure
		redirect_to root_path
	end

end