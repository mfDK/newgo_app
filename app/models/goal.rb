class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :tasks

  # def fb_post_goal_complete
  # 	begin
  # 		fb_post
  # 	rescue Koala::Facebook::APIError => exc
  # 		flash[:alert] = "Goal Completed!"
  # 	end
  # end

  

end
