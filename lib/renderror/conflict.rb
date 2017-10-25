module Renderror
  class Conflict < Renderror::BaseError
    def status
      '409'
    end

    def default_title
      'Conflict'
    end

    def default_detail
      'Incorrect type specified'
    end
  end
end
