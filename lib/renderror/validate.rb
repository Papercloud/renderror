module Renderror
  module Validate
    extend ActiveSupport::Concern

    PERMITTED_VALIDATIONS = %i[
      jsonapi_type jsonapi_id
    ].freeze

    included do
      def validate_jsonapi_type
        return unless params['data'].present?

        raise Renderror::Conflict unless type_matches?
      end

      def type_matches?
        params['data'].try(:[], 'type') == jsonapi_type
      end

      # This can be overwritten on a per-controller basis if the type name
      # doesn't match the controller name
      def jsonapi_type
        controller_name.dasherize
      end

      def validate_jsonapi_id
        return unless params['data'].present?
        return if id_matches?

        raise Renderror::Conflict.new(detail: 'Incorrect resource ID')
      end

      def id_matches?
        params.dig(:data, :id) == params[:id]
      end
    end

    module ClassMethods
      def renderror_validate(*validations)
        sanitized_validations(validations).each do |validation|
          send("validate_#{validation}")
        end
      end

      def sanitized_validations(validation_list)
        validation_list.select { |e| PERMITTED_VALIDATIONS.include? e }
      end

      def validate_jsonapi_type
        before_action :validate_jsonapi_type, only: %i[create update]
      end

      def validate_jsonapi_id
        before_action :validate_jsonapi_id, only: :update
      end
    end
  end
end
