module Renderror
  class Conflict < Renderror::BaseError
    def status
      '409'
    end

    def default_title
      I18n.t(:"renderror.conflict.title")
    end

    def default_detail
      I18n.t(:"renderror.conflict.detail")
    end
  end
end
