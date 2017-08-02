module Renderror
  module AutoRescue
    extend ActiveSupport::Concern

    PERMITTED_EXCEPTIONS = %i[
      bad_request not_found invalid_document cancan
    ].freeze

    included do
    end

    module ClassMethods
      def renderror_auto_rescue(*exceptions)
        sanitized_exceptions(exceptions).each do |e|
          send("rescue_#{e}")
        end
      end

      def sanitized_exceptions(exception_list)
        exception_list.select { |e| PERMITTED_EXCEPTIONS.include? e }
      end

      def rescue_bad_request
        rescue_from ActionController::BadRequest do |exception|
          render_errors(
            [Renderror::BadRequest.new(detail: exception.message)]
          )
        end
      end

      def rescue_not_found
        rescue_from ActiveRecord::RecordNotFound do |exception|
          render_errors(
            [Renderror::NotFound.new(detail: exception.message)]
          )
        end
      end

      def rescue_invalid_document
        rescue_from ActiveModelSerializers::Adapter::
          JsonApi::Deserialization::InvalidDocument do |exception|
          render_errors(
            [Renderror::BadRequest.new(detail: exception.message)]
          )
        end
      end

      def rescue_cancan
        rescue_from CanCan::AccessDenied do |exception|
          render_errors(
            [Renderror::Forbidden.new(detail: exception.message)]
          )
        end
      end
    end
  end
end
