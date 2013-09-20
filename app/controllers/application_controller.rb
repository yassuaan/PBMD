class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :change_bootstrap
  
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
