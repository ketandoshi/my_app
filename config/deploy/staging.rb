# server-based syntax
# ======================
# Defines a single server with a list of roles and multiple properties.
# You can define all roles on a single server, or split them:

# server "example.com", user: "deploy", roles: %w{app db web}, my_property: :my_value
# server "example.com", user: "deploy", roles: %w{app web}, other_property: :other_value
# server "db.example.com", user: "deploy", roles: %w{db}



# role-based syntax
# ==================

# Defines a role with one or multiple servers. The primary server in each
# group is considered to be the first unless any hosts have the primary
# property set. Specify the username and a domain or IP for the server.
# Don't use `:all`, it's a meta role.

# role :app, %w{deploy@example.com}, my_property: :my_value
# role :web, %w{user1@primary.com user2@additional.com}, other_property: :other_value
# role :db,  %w{deploy@example.com}



# Configuration
# =============
# You can set any configuration variable like in config/deploy.rb
# These variables are then only loaded and set in this stage.
# For available Capistrano configuration variables see the documentation page.
# http://capistranorb.com/documentation/getting-started/configuration/
# Feel free to add new variables to customise your setup.



# Custom SSH Options
# ==================
# You may pass any option but keep in mind that net/ssh understands a
# limited set of options, consult the Net::SSH documentation.
# http://net-ssh.github.io/net-ssh/classes/Net/SSH.html#method-c-start
#
# Global options
# --------------
#  set :ssh_options, {
#    keys: %w(/home/user_name/.ssh/id_rsa),
#    forward_agent: false,
#    auth_methods: %w(password)
#  }
#
# The server-based syntax can be used to override options:
# ------------------------------------
# server "example.com",
#   user: "user_name",
#   roles: %w{web app},
#   ssh_options: {
#     user: "user_name", # overrides user setting above
#     keys: %w(/home/user_name/.ssh/id_rsa),
#     forward_agent: false,
#     auth_methods: %w(publickey password)
#     # password: "please use keys"
#   }

# Check if region is mentioned. Else throw exception.
unless ENV.has_key?("XXT_ALL") || ENV.has_key?("XXT_SG") || ENV.has_key?("XXT_MY") || ENV.has_key?("XXT_HK") ||
    ENV.has_key?("XXTUP_ALL") || ENV.has_key?("XXTUP_SG") || ENV.has_key?("XXTUP_MY") || ENV.has_key?("XXTUP_HK") ||
    ENV.has_key?("SANDBOX2") || ENV.has_key?("SGSCAN")
  puts "  * !!!!!!!!!!!"
  puts "  * Error: Please provide target region."
  puts "  * Usage: cap staging deploy XXT_ALL=true"
  puts "  * !!!!!!!!!!!"
  raise "No region provided!"
  exit
end

set :environment, 'staging'

set :deploy_to, "/home/deploy_user/capistrano/#{fetch :application}"


set :ssh_options, {
  user: "deploy_user",
  keys: '',
  forward_agent: true,
  auth_methods: %w(publickey)
}

# Set servers
if ENV["XXT_ALL"] == "true" || ENV["XXT_SG"] == "true"
  server ENV.fetch('STAGING_SERVER_IP_ONE'), roles: %w{web app db script job}
elsif ENV["XXT_ALL"] == "true" || ENV["XXT_MY"] == "true"
  server ENV.fetch('STAGING_SERVER_IP_TWO'), roles: %w{web app db script job}
elsif ENV["XXT_ALL"] == "true" || ENV["XXT_HK"] == "true"
  #
end
