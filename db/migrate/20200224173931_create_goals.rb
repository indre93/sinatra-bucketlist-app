class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title
      t.text :description
      t.boolean :completed?
      t.integer :user_id
      
      t.timestamps null: false
    end
  end
end
