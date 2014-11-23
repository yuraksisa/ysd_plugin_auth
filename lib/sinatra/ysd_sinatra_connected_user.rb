require 'ysd_md_rac'

module Sinatra
  module YSD
  	module ConnectedUser
  
      def self.registered(app)
        
        #
        # Before processing any request, assigns the connected user
        #
        # It holds the user and redefines the System::Request.connected_user method
        #
        app.before /^[^.]*$/ do
          
          if user
           	if Thread.current[:connected_user] != user
          	  Thread.current[:connected_user] = user
              Users::ResourceAccessControl.updated_connected_user
            end
          else
          	if not Thread.current[:connected_user].nil? and not Thread.current[:connected_user] == Users::Profile.ANONYMOUS_USER
          	  Thread.current[:connected_user] = Users::Profile.ANONYMOUS_USER
              Users::ResourceAccessControl.updated_connected_user
            end
          end

        end    
         
      end


  	end
  end
end