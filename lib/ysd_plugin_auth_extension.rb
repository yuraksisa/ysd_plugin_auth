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
          
    # Retrieve all the blocks defined in this module 
    # 
    # @param [Hash] context
    #   The context
    #
    # @return [Array]
    #   The blocks defined in the module
    #
    #   An array of Hash which the following keys:
    #
    #     :name         The name of the block
    #     :module_name  The name of the module which defines the block
    #     :theme        The theme
    #
    def block_list(context={})
    
      app = context[:app]
    
      [{:name => 'auth_login',
        :module_name => :auth,
        :theme => Themes::ThemeManager.instance.selected_theme.name}]
        
    end

    # Get a block representation 
    #
    # @param [Hash] context
    #   The context
    #
    # @param [String] block_name
    #   The name of the block
    #
    # @return [String]
    #   The representation of the block
    #    
    def block_view(context, block_name)
    
      app = context[:app]
        
      case block_name

        when 'auth_login'
           login_locals = {}
           login_locals.store(:show_create_account, false)
           login_locals.store(:show_password_forgotten, false)
           login_locals.store(:login_strategies, 
             Plugins::Plugin.plugin_invoke_all('login_strategy', 
             context).join(" ") || '')

           login_form = app.partial(:login, :locals => login_locals)
      end
      
    end

    #
    # ---------- Path prefixes to be ignored ----------
    #

    #
    # Ignore the following path prefixes in language processor
    #
    def ignore_path_prefix_language(context={})
      %w(/login /logout /unauthenticated)
    end

    #
    # Ignore the following path prefix in cms
    #
    def ignore_path_prefix_cms(context={})
      %w(/login /logout /unauthenticated)
    end

    #
    # Ignore the following path prefix in breadcrumb
    #
    def inore_path_prefix_breadcrumb(context={})
      %w(/login /logout /unauthenticated)
    end  
    
      
  end #AuthExtension
end #Huasi