require_relative 'lib/locomotive/coal/version'

Gem::Specification.new do |spec|
  spec.name          = 'locomotivecms_coal'
  spec.version       = Locomotive::Coal::VERSION
  spec.authors       = ['Didier Lafforgue']
  spec.email         = ['did@locomotivecms.com']
  spec.description   = %q{The LocomotiveCMS coal is the API ruby client for LocomotiveCMS}
  spec.summary       = %q{The LocomotiveCMS coal is the API ruby client for LocomotiveCMS}
  spec.homepage      = 'http://www.locomotivecms.com'
  spec.homepage      = 'https://github.com/locomotivecms/coal'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler',    '~> 1.9.1'
  spec.add_development_dependency 'rake',       '~> 10.4.2'

  spec.add_dependency 'unirest',                '~> 1.1.2'
  spec.add_dependency 'activesupport',          '~> 4.2.0'

  spec.required_ruby_version = '>= 2.0'
end
