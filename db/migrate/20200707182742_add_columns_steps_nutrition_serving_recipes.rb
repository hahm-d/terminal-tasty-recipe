class AddColumnsStepsNutritionServingRecipes < ActiveRecord::Migration[5.2]
  def change
    add_column :recipes, :calories, :integer
    add_column :recipes, :description, :text
    add_column :recipes, :total_time, :integer
    add_column :recipes, :num_serving, :integer
    add_column :recipes, :keywords, :text
  end
end
