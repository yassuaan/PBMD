class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :change_bootstrap

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
  
end
