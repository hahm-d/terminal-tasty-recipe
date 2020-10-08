class CreateInstructions < ActiveRecord::Migration[5.2]
  def change
    create_table :instructions do |t|
      t.text :step
      t.integer :recipe_id
    end
  end
end
