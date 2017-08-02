module Renderror
  module Configuration
    mattr_accessor :controller_adapters

    @@controller_adapters = %w[rails rails_api rails_metal]

    # Allow the default configuration to be overwritten from initializers
    def configure
      yield self if block_given?
    end
  end
end
