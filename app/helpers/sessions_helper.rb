module SessionsHelper
  
  def store_location
    sessions[:return_to] = request.fullpath
  end
  
  def clear_stored_location
    sessions[:return_to] = nil
    
  end
  
end