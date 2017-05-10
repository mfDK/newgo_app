class User < ActiveRecord::Base

	has_many :goals

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]
         # This is setting ominauth to be able to connect with facebook
         # through OAuth in rails

  # This from_omniauth method brings back the user object and
  # brings back info of the user from the OAuth hash
  def self.from_omniauth(auth)
  	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  		user.provider = auth.provider
  		user.uid 			= auth.uid
  		user.email 		= auth.info.email
  		user.password = Devise.friendly_token[0,20]
  	end
  end

end
