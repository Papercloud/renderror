# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'renderror/version'

Gem::Specification.new do |spec|
  spec.name          = 'renderror'
  spec.version       = Renderror::VERSION
  spec.authors       = ['Isaac Norman']
  spec.email         = ['isaacdnorman@gmail.com']

  spec.summary       = 'Render Errors Easily'
  spec.description   = 'Adds easy renderring to your JSON API'
  spec.homepage      = 'https://github.com/Papercloud/renderror'
  spec.license       = 'MIT'
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'https://rubygems.org'
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '> 4.2', '< 6.0'

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
