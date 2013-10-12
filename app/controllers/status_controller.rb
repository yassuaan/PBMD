class StatusController < ApplicationController
  def info

    @user = User.find(session['user_id'])
    @fuser = OauthFacebook.where(:fuid => @user.facebook_id).first
    @tuser = OauthTwitter.where(:tuid => @user.twitter_id).first
    
  end
  

  
end

