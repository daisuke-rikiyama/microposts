class RetweetsController < ApplicationController
    before_action :logged_in_user
    
    def create
        # 元になったmicropost
        @micropost = Micropost.find(params[:micropost_id])
        # リツイートとの関係を記録する
        @retweet = current_user.retweets.build(micropost: @micropost)
        # ログインしているユーザーがリツイートするツイート
        @retweeted_micropost = Micropost.new content: @micropost.content, user_id: current_user.id, original_micropost_id: @micropost.id
        if @retweet.save && @retweeted_micropost.save
            flash[:success] = "Retweet Successed!"
            redirect_to root_url
        else
            flash[:danger] = "Retweet Failed!"
            redirect_to request.referrer
        end
    end
    
    def destroy
        @retweet = current_user.retweets.find_by!(micropost_id: params[:micropost_id])
        @micropost = Micropost.find_by(original_micropost_id: params[:micropost_id])
        @retweet.destroy
        flash[:success] = "Retweet deleted!"
        unless @micropost.nil?
            @micropost.destroy
            flash[:danger] = "Posted retweet deleted!"
        end
        redirect_to request.referrer
    end
end
