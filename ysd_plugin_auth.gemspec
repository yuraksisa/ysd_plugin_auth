Gem::Specification.new do |s|
  s.name    = "ysd_plugin_auth"
  s.version = "0.1.25"
  s.authors = ["Yurak Sisa Dream"]
  s.date    = "2012-06-08"
  s.email   = ["yurak.sisa.dream@gmail.com"]
  s.files   = Dir['lib/**/*.rb','views/**/*.erb','i18n/**/*.yml','static/**/*.*'] 
  s.description = "Auth integration"
  s.summary = "Auth integration"

  s.add_runtime_dependency "warden"                # Authorization
  s.add_runtime_dependency "sinatra-flash"
  
  s.add_runtime_dependency "ysd_plugin_cms"        # Page serving
  s.add_runtime_dependency "ysd_plugin_profile"    # Signup and password forgetten links (in views)
  s.add_runtime_dependency "ysd_core_themes"       # Serving static content
  s.add_runtime_dependency "ysd_core_plugins"      # Plugins 
  
end