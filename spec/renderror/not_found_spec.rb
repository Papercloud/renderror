require 'spec_helper'

RSpec.describe Renderror::NotFound do
  describe 'Defaults' do
    subject { described_class.new }

    it 'sets the title' do
      expect(subject.title).to eq I18n.t(:"renderror.not_found.title")
    end

    it 'sets the status' do
      expect(subject.status).to eq '404'
    end

    it 'sets a message' do
      expect(subject.detail).to eq \
        I18n.t(:"renderror.not_found.detail")
    end

    it 'renders the correct JSON' do
      json = {
        'status' => '404',
        'title' => I18n.t(:"renderror.not_found.title"),
        'detail' => I18n.t(:"renderror.not_found.detail"),
        'pointer' => nil
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
        'status' => '404',
        'title' => 'Oops',
        'detail' => 'Something\'s Not Right',
        'pointer' => nil
      }

      expect(subject.to_json).to eq json
    end
  end
end
