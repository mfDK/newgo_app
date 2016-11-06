class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title, :description, :end_date, presence: true
  validates :title, length: { minimum: 5, maximum: 50 }
  validates :description, length: { minimum: 5, maximum: 140 }

  # def fb_post_goal_complete
  # 	begin
  # 		fb_post
  # 	rescue Koala::Facebook::APIError => exc
  # 		flash[:alert] = "Goal Completed!"
  # 	end
  # end

end
