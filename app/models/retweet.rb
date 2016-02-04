# == Schema Information
#
# Table name: retweets
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  micropost_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_retweets_on_created_at    (created_at)
#  index_retweets_on_micropost_id  (micropost_id)
#  index_retweets_on_user_id       (user_id)
#

class Retweet < ActiveRecord::Base
    belongs_to :user
    belongs_to :micropost
    
    validates :user, presence: true
    validates :user_id, uniqueness: { scope: :micropost_id }
    validates :micropost, presence: true
end
