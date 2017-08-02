module Renderror
  module ReformUnprocessable
    extend ActiveSupport::Concern

    included do
      def render_reform_unprocessable(form)
        render_errors(reform_errors(form))
      end

      def reform_errors(form)
        form.errors.messages.map do |(field, errors)|
          errors.map do |error|
            Renderror::UnprocessableEntity.new(
              detail: "#{humanize_field(field)} #{error}",
              pointer: "/data/attributes/#{field.to_s.dasherize}"
            )
          end
        end.flatten
      end

      def humanize_field(field)
        field.to_s.split('.').join(' ').humanize
      end
    end
  end
end
