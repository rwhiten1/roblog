class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :check_authentication
  
  def check_authentication
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name
      redirect_to :action => "login"
    end
  end
  
  
end
