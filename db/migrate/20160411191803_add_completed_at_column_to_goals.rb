class AddCompletedAtColumnToGoals < ActiveRecord::Migration
  def change
  	add_column :goals, :completed_at, :datetime
  end
end
