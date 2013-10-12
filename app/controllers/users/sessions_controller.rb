class Users::SessionsController < Devise::SessionsController
 
  def new
    super
    
    session[:user_id] = current_user.id
  end
 
  def create
    super
    
    session[:user_id] = current_user.id
  end
end