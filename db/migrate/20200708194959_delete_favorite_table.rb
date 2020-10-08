class DeleteFavoriteTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :favorites
  end
end
