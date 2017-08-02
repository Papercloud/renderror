require 'rails/generators'

module Renderror
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def copy_initializer
      template 'en.yml', 'config/locales/renderror.en.yml'
    end
  end
end
