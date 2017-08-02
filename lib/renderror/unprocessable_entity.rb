module Renderror
  class UnprocessableEntity < BaseError
    def status
      '422'
    end

    private

    def default_title
      I18n.t(:"renderror.unprocessable_entity.title")
    end

    def default_detail
      I18n.t(:"renderror.unprocessable_entity.detail")
    end
  end
end
