module Sinatra
  #
  # Helper for authentication and authorization
  #
  # http://alex.cloudware.it/2010/04/sinatra-warden-catch.html
  #
  module Auth
    
      def warden
        env['warden']
      end
    
      # Return session info
      # 
      # @param [Symbol] The scope
      def session_info(scope=nil)
    
       scope ? warden.session(scope) : warden.session
    
      end
    
      # 
      # Check the current session is authenticated to a given scope
      #
      # @param [Symbol] The scope 
      def authenticated?(scope=nil)

        p "checking authenticated? #{user(scope) ? user(scope).username : 'no user'}"

        scope ? warden.authenticated?(scope) : warden.authenticated?
      
      end
      
      # Authenticate the user against defined strategies
      #
      #
      def authenticate(*args)
        warden.authenticate!(*args)
      end
    
      # Require authorization for the action
      # 
      #
      def authorized! (failure_path)
    
        unless authenticated? or (user and user.belongs_to?('anonymous'))
          session[:return_to] = request.path 
          redirect failure_path
        end
    
      end
      
      # Terminates the current session
      #
      # @param [Symbol] The session scope to terminate
      def logout(scope = nil)

        p "Logout"
        scope ? warden.logout(scope) : warden.logout
    
      end
      
      # Access the user from the current session
      #
      # @param [Symbol] The scope from the logged in user
      def user(scope = nil)
      
        scope ? warden.user(scope) : warden.user
      
      end
      
      # Store the logged in user in the session
      #
      # @param[object] the user you want to store in the session
      # @param opts the options ( :store => false :scope => 'scope' ....)
      def user=(new_user, options={})
        warden.set_user(new_user, options)
      end
      
    end
      
  helpers Auth
end