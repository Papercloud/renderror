require 'spec_helper'

RSpec.describe Renderror::Forbidden do
  describe 'Defaults' do
    subject { described_class.new }

    it 'sets the title' do
      expect(subject.title).to eq I18n.t(:"renderror.forbidden.title")
    end

    it 'sets the status' do
      expect(subject.status).to eq '403'
    end

    it 'sets a message' do
      expect(subject.detail).to eq \
        I18n.t(:"renderror.forbidden.detail")
    end

    it 'renders the correct JSON' do
      json = {
        'status' => '403',
        'title' => I18n.t(:"renderror.forbidden.title"),
        'detail' => I18n.t(:"renderror.forbidden.detail")
      }

      expect(subject.to_json).to eq json
    end
  end

  describe 'Setting attributes' do
    subject do
      described_class.new(title: 'Oops', detail: 'Something\'s Not Right')
    end

    it 'sets the title' do
      expect(subject.title).to eq 'Oops'
    end

    it 'sets a message' do
      expect(subject.detail).to eq 'Something\'s Not Right'
    end

    it 'renders the correct JSON' do
      json = {
        'status' => '403',
        'title' => 'Oops',
        'detail' => 'Something\'s Not Right'
      }

      expect(subject.to_json).to eq json
    end
  end
end
