class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.integer :user_id
      t.integer :micropost_id

      t.timestamps null: false
    end
  end
end
