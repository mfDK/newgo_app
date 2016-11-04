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
  def find_goal_task
    @goal = Goal.find(params[:id])
    @tasks = @goal.tasks
    @completed_tasks = @tasks.map { |completed| completed.completed_at }
  end
  def complete_goal
    if @completed_tasks.all?
      @goal.update_attribute(:completed_at, Time.zone.now)
    end
  end

end
