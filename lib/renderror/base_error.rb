module Renderror
  class BaseError < RuntimeError
    def initialize(title: default_title, detail: default_detail, pointer: nil)
      @title = title
      @detail = detail
      @pointer = pointer
    end

    def to_json
      Hash.new.tap do |hash|
        hash['status'] = status
        hash['title'] = title
        hash['detail'] = detail
        hash['source'] = { 'pointer' => pointer } if pointer
      end
    end

    def status
      @status ||= I18n.t(:"renderror.base_error.status")
    end

    def title
      @title ||= I18n.t(:"renderror.base_error.title")
    end

    def detail
      @detail ||= I18n.t(:"renderror.base_error.detail")
    end

    def pointer
      @pointer ||= nil
    end

    private

    def default_title
      I18n.t(:"renderror.base_error.title")
    end

    def default_detail
      I18n.t(:"renderror.base_error.detail")
    end
  end
end
