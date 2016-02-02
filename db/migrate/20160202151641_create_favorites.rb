class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps null: false
      
      t.index :user_id
      t.index :micropost_id
      t.index :created_at
    end
  end
end
