class DefaultTastyTables < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :name
      t.integer :tasty_remote_id
    end

    create_table :dishes do |t|
      t.integer :recipe_id
      t.integer :user_id
      t.integer :user_like
    end
  end
end
