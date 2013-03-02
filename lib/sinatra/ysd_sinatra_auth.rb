require 'sinatra/flash'
require 'ysd-plugins' if not defined?Plugins

module Sinatra
  module YSD
    #
    # Setting up
    # ----------
    # 
    # Use the Sinatra::Auth helper to manage the access to protected resources and this application, Middleware::Login, if you want
    # a middleware to manage the login routes ( GET /login, POST /login, POST /unauthenticated, GET /logout) and free this tasks
    #
    # - Configuring your Rack endpoint
    #
    # a. Configure warden in your sinatra endpoint
    #
    # b. Configure it in your sinatra application 
    #
    #   register Sinatra::AuthenticationAuthorization
    #
    # Howto
    # ----------
    #
    # - When your application wants to check if the user can access a resource, use the authorized! method 
    #
    #     authorized!(failure_path)
    # 
    #       The failure_path is the endpoint that will respond with the loginform, which will make a POST /login 
    # 
    # - The endpoint POST /login does the authentication (using warden.authenticate!)
    # 
    #     If the user can be authenticated, the /unauthorized endpoint is called
    #
    #
    # Specific application settings
    # -----------------------------
    #
    #   :success_path    -> To redirect if the identification is right
    #   :failure_path    -> To redirect if the identification is wrong
    #   :logout_path     -> To redirect when the user logs out
    #   :login_page      -> The resource that represents the login page
    #
    module AuthenticationAuthorization
      
      def self.registered(app)
                
        app.helpers Sinatra::Auth
        app.register Sinatra::Flash

        # Specific application settings
        app.set :success_path, "/"
        app.set :failure_path, "/login"
        app.set :logout_path, "/"
        app.set :login_page, :login

        # Add the local folders to the views and translations     
        app.settings.views = Array(app.settings.views).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'views')))
        app.settings.translations = Array(app.settings.translations).push(File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'i18n')))       

        # Login form
        #
        app.get '/login/?' do
          
          locals = {}
          locals.store(:show_create_account, SystemConfiguration::Variable.get_value('auth.create_account','false').to_bool)
          locals.store(:show_password_forgotten, SystemConfiguration::Variable.get_value('auth.show_password_forgotten','false').to_bool)
          locals.store(:login_strategies, Plugins::Plugin.plugin_invoke_all('login_strategy', {:app => self}).join(" ") || '')

          load_page('login', :locals => locals) 
        end
    
        # Post login
        #
        app.post '/login/?' do
          if authenticated?
            logout
          end
          authenticate
          redirect(session[:return_path] ? session[:return_to] : settings.success_path)
        end
  
        # logout
        #
        app.get '/logout/?' do
          authorized!(settings.failure_path)
          logout
          redirect(settings.logout_path)
        end
  
        # Unauthenticated request
        # 
        app.post '/unauthenticated/?' do
          status 401
          flash[:error]= t.auth_messages.message_error_login 
          redirect settings.failure_path
        end
    
        #
        # Serves static content from the extension
        #
        app.get "/auth/*" do
            
            serve_static_resource(request.path_info.gsub(/^\/auth/,''), File.join(File.dirname(__FILE__), '..', '..', 'static'), 'auth')
            
        end 
    
    
      end
    
    end #AuthenticationAuthorization
  end # YSD
end # Sinatra