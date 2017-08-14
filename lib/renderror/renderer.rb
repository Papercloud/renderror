require 'renderror/reform_unprocessable'
require 'renderror/render_unprocessable'
require 'renderror/render_invalid_authentication'

module Renderror
  module Renderer
    extend ActiveSupport::Concern

    included do
      include RenderUnprocessable
      include ReformUnprocessable
      include RenderInvalidAuthentication

      def render_errors(errors)
        render json: { errors: Array(errors).map(&:to_json) },
               status: Array(errors)[0].status
      end
    end
  end
end
