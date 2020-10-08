class CreateUserTables < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :f_name
      t.string :l_name
      t.date :dob
      t.string :f_food
      t.string :username
    end

    create_table :favorites do |t|
      t.integer :user_id
      t.integer :tasty_remote_id
    end

    create_table :search_histories do |t|
      t.string :s_text
      t.integer :user_id
    end

  end
end
