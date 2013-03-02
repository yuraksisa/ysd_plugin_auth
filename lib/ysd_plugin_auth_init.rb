require 'ysd-plugins' unless defined?Plugins::Plugin
require 'ysd_plugin_auth_extension'

Plugins::SinatraAppPlugin.register :auth do

   name=        'auth'
   author=      'yurak sisa'
   description= 'Integrate the auth application'
   version=     '0.1'
   sinatra_helper    Sinatra::Auth
   sinatra_extension Sinatra::YSD::AuthenticationAuthorization
   sinatra_extension Sinatra::YSD::ConnectedUser
   hooker            Huasi::AuthExtension
  
end