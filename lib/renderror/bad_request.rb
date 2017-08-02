module Renderror
  class BadRequest < BaseError
    def status
      '400'
    end

    private

    def default_title
      I18n.t(:"renderror.bad_request.title")
    end

    def default_detail
      I18n.t(:"renderror.bad_request.detail")
    end
  end
end
