module Renderror
  class Unauthorized < BaseError
    def status
      '401'
    end

    private

    def default_detail
      I18n.t(:"renderror.unauthorized.detail")
    end

    def default_title
      I18n.t(:"renderror.unauthorized.title")
    end
  end
end
