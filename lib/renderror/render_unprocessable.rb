module Renderror
  module RenderUnprocessable
    extend ActiveSupport::Concern

    included do
      def render_unprocessable(resource)
        render_errors(entity_errors(resource))
      end

      private

      def entity_errors(resource)
        resource.errors.map do |field, error|
          Renderror::UnprocessableEntity.new(
            detail: resource.errors.full_message(field, error),
            pointer: pointer_for(field)
          )
        end
      end

      def pointer_for(field)
        return if field == :base
        "/data/attributes/#{field.to_s.dasherize}"
      end
    end
  end
end
