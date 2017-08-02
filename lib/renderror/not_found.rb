module Renderror
  class NotFound < BaseError
    def status
      '404'
    end

    private

    def default_title
      I18n.t(:"renderror.not_found.title")
    end

    def default_detail
      I18n.t(:"renderror.not_found.detail")
    end
  end
end
