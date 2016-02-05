class AddOriginalUserNameToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :original_user_name, :string
  end
end
