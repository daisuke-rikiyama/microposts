class AddOriginalMicropostIdToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :original_micropost_id, :integer
  end
end
