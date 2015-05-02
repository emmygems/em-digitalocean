# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'digitalocean/version'

Gem::Specification.new do |spec|
  spec.name          = "em-digitalocean"
  spec.version       = Digitalocean::VERSION
  spec.authors       = ["inre"]
  spec.email         = ["inre.storm@gmail.com"]

  spec.summary       = %q{DigitalOcean API EventMachine-based}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "emmy-machine"
  spec.add_dependency "emmy-http", '>= 0.2.2'
  spec.add_dependency "emmy-http-client", '>= 0.1.7'

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
