require 'spec_helper'

RSpec.describe Renderror::BadRequest do
  describe 'Defaults' do
    subject { described_class.new }

    it 'sets the title' do
      expect(subject.title).to eq 'Bad Request'
    end

    it 'sets the status' do
      expect(subject.status).to eq '400'
    end

    it 'sets a message' do
      expect(subject.detail).to eq 'Bad Request'
    end

    it 'renders the correct JSON' do
      json = {
        'status' => '400',
        'title' => 'Bad Request',
        'detail' => 'Bad Request',
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
        'status' => '400',
        'title' => 'Oops',
        'detail' => 'Something\'s Not Right',
        'pointer' => nil
      }

      expect(subject.to_json).to eq json
    end
  end
end
