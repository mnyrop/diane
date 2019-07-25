# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib')

Gem::Specification.new do |spec|
  spec.name          = 'diane'
  spec.version       = '0.0.3'
  spec.authors       = ['mnyrop']
  spec.email         = ['m.nyrop@columbia.edu']

  spec.summary       = %(CL gem for recording and playing back thoughts.)
  spec.description   = %(CL gem for recording and playing back thoughts/
    intel/ motivations without bloating the Git logs.)
  spec.homepage      = 'https://github.com/mnyrop/diane'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.executables   = ['diane']
  spec.require_paths = ['lib']

  spec.add_dependency 'colorize', '~> 0.8'
  spec.add_dependency 'mercenary', '~> 0.3'
  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'faker', '~> 1'
  spec.add_development_dependency 'rspec', '~> 3'
end
