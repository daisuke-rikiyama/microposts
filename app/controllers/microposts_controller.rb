# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_microposts_on_user_id                 (user_id)
#  index_microposts_on_user_id_and_created_at  (user_id,created_at)
#

class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    
    def create
        @micropost = current_user.microposts.build(micropost_params)
        if @micropost.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            render 'static_pages/home'
        end
    end
    
    def destroy
        @micropost = current_user.microposts.find_by(id: params[:id])
        @retweet = current_user.retweets.find_by(micropost_id: @micropost.original_micropost_id)
        return redirect_to root_url if @micropost.nil?
        @micropost.destroy
        flash[:success] = "Micropost deleted!"
        unless @retweet.nil?
            @retweet.destroy
            flash[:danger] = "Retweet deleted!"
        end
        redirect_to request.referrer || root_url
    end
    
    private
    def micropost_params
        params.require(:micropost).permit(:content, :picture)
    end
end
