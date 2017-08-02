module Renderror
  module RenderInvalidAuthentication
    extend ActiveSupport::Concern

    included do
      def render_invalid_authentication
        render_errors(
          [
            Renderror::Unauthorized.new(
              detail: I18n.t(:"renderror.unauthorized.invalid_auth")
            )
          ]
        )
      end
    end
  end
end
