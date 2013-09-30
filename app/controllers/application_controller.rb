class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :change_bootstrap, :login_info
  
  helper_method :current_user, :user_signed_in?

  def change_bootstrap
    if params[:stylevariety]
      @changeboot = params[:stylevariety]
      cookies[:bootstylesheet_favorite] = @changeboot
    elsif cookies[:bootstylesheet_favorite]
      @changeboot = cookies[:bootstylesheet_favorite]
    else
      @changeboot = "cerulean"
    end
    
  end
  
  def login_info
    case session[:provider]
    when 'twitter'
      @provider = ['facebook']
      
    when 'facebook'
      @provider = ['twitter']
      
    else
      status = User.find(session[:user_id])
      unless status[:facebook_id] && status[:twitter_id]
        @provider = ['twitter', 'facebook']
      end
      
    end
    
  end
  
  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  
    def user_signed_in?
      if session[:user_id]
        return true
      else
        return false
      end
    end
    
end
