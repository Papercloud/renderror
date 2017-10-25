require 'active_support'
require 'renderror/configuration'
require 'renderror/auto_rescue'
require 'renderror/validate'
require 'renderror/renderer'

require 'renderror/base_error'
require 'renderror/bad_request'
require 'renderror/unauthorized'
require 'renderror/forbidden'
require 'renderror/not_found'
require 'renderror/unprocessable_entity'
require 'renderror/conflict'

module Renderror
  extend Configuration

  I18n.load_path << File.expand_path('./lib/generators/renderror/install/templates/en.yml')
end

module ActionController
  class Base
    include Renderror::AutoRescue
    include Renderror::Validate
    include Renderror::Renderer
  end
end
