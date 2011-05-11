Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "160343384030567", "75b140df0def2a3932a82380d04f1449", 
    {:scope => 'email, offline_access',:client_options => {:ssl => {:ca_path => "/etc/ssl/certs/ca-certificates.crt"}}}
end

#OmniAuth::Strategies::Facebook.class_eval do 
#  #This monkey patches the oa-oauth gem to reduce the default amount of access your app asks for
#  #The reasoning here is that there is a "strong inverse correlation" between the amount of data you ask
#  # for and the likelihood a user will give you access. Scaring users is not a good idea in Ecommerce
#
#  def request_phase
#    options[:scope] ||= "email"
#    super
#  end      
#end