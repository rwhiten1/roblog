# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_roblog_session',
  :secret => '6724627fbef328799b5147c5ea18a9080b4db65a357c467be6c6a76b030c552069a2ec3bb31100263d5b78ec9d16abb03c6245657fa1359feee91e3d8e47ae0b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
