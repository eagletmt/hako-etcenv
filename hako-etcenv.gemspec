# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'hako-etcenv'
  spec.version       = '0.1.2'
  spec.authors       = ['Kohei Suzuki']
  spec.email         = ['eagletmt@gmail.com']

  spec.summary       = 'Provide variables from etcd to hako using etcenv'
  spec.description   = 'Provide variables from etcd to hako using etcenv'
  spec.homepage      = 'https://github.com/eagletmt/hako-etcenv'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'etcenv'
  spec.add_dependency 'hako', '>= 0.2.0'
  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rubocop'
end
