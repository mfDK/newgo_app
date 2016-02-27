class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.references :goal, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.datetime :end_date
      t.boolean :completed

      t.timestamps null: false
    end
  end
end
