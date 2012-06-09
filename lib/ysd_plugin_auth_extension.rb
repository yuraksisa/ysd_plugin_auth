require 'ysd-plugins_viewlistener' unless defined?Plugins::ViewListener

#
# Auth Extension
#
module Huasi

  class AuthExtension < Plugins::ViewListener
            
    # ========= Page Building ============
    
    #
    # It gets the style sheets defined in the module
    #
    # @param [Context]
    #
    # @return [Array]
    #   An array which contains the css resources used by the module
    #
    def page_style(context={})
      ['/auth/css/login.css']     
    end

      
  end #AuthExtension
end #Huasi