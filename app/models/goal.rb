class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title, :description, :end_date, presence: true

  # def fb_post_goal_complete
  # 	begin
  # 		fb_post
  # 	rescue Koala::Facebook::APIError => exc
  # 		flash[:alert] = "Goal Completed!"
  # 	end
  # end

  

end
