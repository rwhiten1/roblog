class AdminConsoleController < ApplicationController
  before_filter :check_authentication, :except => [:login]
  
  def check_authentication
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name
      redirect_to :action => "login"
    end
  end
  
  def login_form
    render
  end
  
  def login
    if request.post?
      user = User.authenticate(params[:username], params[:password])
      if user
        session[:user_id] = user.id
        if session[:intended_controller]
          redirect_to :action => session[:intended_action], :controller => session[:intended_controller]
        else
          redirect_to :controller => 'articles', :action => 'index'
        end
      else
        flash.now[:notice] = "Invalid user/password combination"
        redirect_to :action => "index", :controller => "articles"
      end
      
    end
  end
  
  def logout
    session[:user] = nil
    redirect_to :controller => "articles", :action => "index"
  end
end
