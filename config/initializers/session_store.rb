# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SEWReportsV3_session',
  :secret      => 'b5d5c1ec9952f3de3eaac12b47103e43107f29e7375db0a2921a79887c3a9a8f2f7252e81774b4379088ab8595a14115cc1a1817a2336a8eafb54dc0845b11cb'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
