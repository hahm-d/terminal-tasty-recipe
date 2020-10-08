class RenameDishTable < ActiveRecord::Migration[5.2]
  def change
    rename_table :dishes, :dish_searches
  end
end
