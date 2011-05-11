Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, "160343384030567", "75b140df0def2a3932a82380d04f1449", {:client_options => {:ssl => {:ca_file => "/usr/lib/ssl/"}}}
end