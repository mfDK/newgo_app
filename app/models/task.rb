class Task < ActiveRecord::Base
  belongs_to :goal
  validates :title, :description, :end_date, presence: true
end
