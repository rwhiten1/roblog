class RegistrationsController < Devise::RegistrationsController
#this controller will override the default redirect after a registration
  protected
  
  def after_sign_up_path_for(resource)
    #need to see if there is anything in the HTTP referer fields
    puts "The request URI was: #{request.fullpath}" 
    #if request.fullpath == "/agents"
    #  agent_path(resource.id)
    #else
    #  request.fullpath
    #end
    request.fullpath
  end
  
end