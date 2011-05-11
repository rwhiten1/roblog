Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, FACEBOOK_KEY, FACEBOOK_SECRET, {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end