# == Schema Information
#
# Table name: microposts
#
#  id                    :integer          not null, primary key
#  user_id               :integer
#  content               :text
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  original_micropost_id :integer
#  original_user_name    :string
#  picture               :string
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#

class Micropost < ActiveRecord::Base
  belongs_to :user
  mount_uploader :picture, PictureUploader
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  validate :picture_size
  
  has_many :favorites, dependent: :destroy
  has_many :retweets, dependent: :destroy
  
  def favorited_by? user
    favorites.where(user_id: user.id).exists?
  end
  
  def retweeted_by? user
    retweets.where(user_id: user.id).exists?
  end
  
  private
  
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
