require 'ysd-plugins_viewlistener' unless defined?Plugins::ViewListener

#
# Auth Extension
#
module Huasi

  class AuthExtension < Plugins::ViewListener
  
    # ========= Installation =================

    # 
    # Install the plugin
    #
    def install(context={})
            
        SystemConfiguration::Variable.first_or_create({:name => 'auth.create_account'}, 
                                                      {:value => 'false', :description => 'allow creating an account', :module => :auth}) 

        SystemConfiguration::Variable.first_or_create({:name => 'auth.show_password_forgotten'}, 
                                                      {:value => 'false', :description => 'show password forgotten in login', :module => :auth}) 

    end  
            
    # ========= Page Building ============
    
    #
    # It gets the style sheets defined in the module
    #
    # @param [Context]
    #
    # @return [Array]
    #   An array which contains the css resources used by the module
    #
    #def page_style(context={})
    #  ['/auth/css/login.css']     
    #end

      
  end #AuthExtension
end #Huasi