require 'active_support/concern'

module Renderror
  class Forbidden < BaseError
    def status
      '403'
    end

    private

    def default_title
      I18n.t(:"renderror.forbidden.title")
    end

    def default_detail
      I18n.t(:"renderror.forbidden.detail")
    end
  end
end
