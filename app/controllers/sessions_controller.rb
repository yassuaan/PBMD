class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    unless session[:user_id]
      case auth['provider']
      when 'facebook'
        fuser = OauthFacebook.find_first_by_auth_conditions(auth["uid"]) || OauthFacebook.create_with_omniauth(auth)
        user = User.find_first_by_auth_conditions({:facebook_id => auth["uid"]}) || User.create_with_omniauth(auth)
      
      when 'twitter'
        tuser = OauthTwitter.find_first_by_auth_conditions(auth["uid"]) || OauthTwitter.create_with_omniauth(auth)
        user = User.find_first_by_auth_conditions({:twitter_id => auth["uid"]})  || User.create_with_omniauth(auth)
      
      end
    
      session[:user_id] = user.id
      session[:provider] = auth['provider']
      redirect_to root_url, :notice => "Signed In!"
      
    else
      oauth_update(auth)
    end
    
  end
  
  def oauth_update(auth)
    obj = User.find(session[:user_id])
    case auth['provider']
    when 'facebook'
      obj.update_attributes(:facebook_id => auth['uid'], :email => auth['info']['email'])
      fuser = OauthFacebook.create_with_omniauth(auth)
      
    when 'twitter'
      obj.update_attributes(:twitter_id => auth['uid'])
      fuser = OauthTwitter.create_with_omniauth(auth)
      
    end
    
    session[:provider] = 'both'  
    
    redirect_to root_path
    
  end
  
  def destroy
    session[:user_id] = nil
    session[:provider] = nil
    redirect_to root_url, :notice => "Signed Out!"
  end
end
