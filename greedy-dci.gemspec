# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'greedy/dci/version'

Gem::Specification.new do |spec|
  spec.name          = "greedy-dci"
  spec.version       = Greedy::DCI::VERSION
  spec.authors       = ["Ritchie Paul Buitre"]
  spec.email         = ["ritchie@richorelse.com"]

  spec.summary       = "A very tiny DCI (Data, context and interaction) toolkit with true ruby implementation without the boiler plate."
  spec.description   = "Toolkit for rapid prototyping of interactors, use cases and service objects. Using DCI (Data, context and interaction) the new programming paradigm from the inventor of the MVC pattern. This implementation consumes excessive memory (hence the name) and is not recommended for production."
  spec.homepage      = "https://github.com/RichOrElse/greedy-dci/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.3.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
