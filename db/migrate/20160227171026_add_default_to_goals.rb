class AddDefaultToGoals < ActiveRecord::Migration
  def change
  	add_column :goals , :completed , :boolean , :default => false
  end
end
