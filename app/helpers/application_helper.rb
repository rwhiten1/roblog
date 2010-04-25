module ApplicationHelper
  def tagged_form_for(name, *args, &block)
    options = args.last.is_a?(Hash) ? args.pop : {}
    options = options.merge(:builder => TaggedBuilder)
    args = (args << options)
    form_for(name,*args,&block)
  end
  
  def check_and_return_user
    if session[:user]
      user = User.find(session[:user])
    end
    user
  end
end
