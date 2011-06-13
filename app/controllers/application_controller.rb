class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery
  
  before_filter :authenticate_user! #, :check_authorization
  #filter_parameter_logging(:pass_hash)
  
  def after_sign_in_path_for(resource_or_scope)
    puts "Request FULLPATH: #{session[:"return_to"]}"
    (session[:"return_to"].nil?) ? "/" : session[:"return_to"].to_s
  end
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied!"
    redirect_to root_url  
  end
  
  def check_authentication
    unless session[:user]
      session[:intended_action] = action_name
      session[:intended_controller] = controller_name
      session[:intended_url] = request.request_uri
      session[:old_params] = params 
      redirect_to :action => "login_form", :controller => "admin_console"
    end
  end
  
  def check_authorization
    puts "-------BEGIN Application#check_authorization--------\n"
    puts "Request URI:  #{request.request_uri}"
      session.each do |k,v|
        puts "session[:#{k.to_s}] = #{v}"
      end
    
    puts "\n-------END Application#check_authorization--------\n\n"
    user = User.find(session[:user])
    
    if user
      unless user.roles.detect do |role|
          role.rights.detect do |right|
            right.action == action_name && right.controller == controller_name
          end
        end

        flash[:notice] = "You are not authorized to view the page you requested: Username > #{user.username} "
        #puts "You are not authorized to view #{controller_name}/#{action_name}"
        request.env["HTTP_REFERER"] ? (redirect_to :back) : (redirect_to "/index")
        return false
      end
    end
    
    
  end
  
  
end
