# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dsc_lcm_configuration/version"

Gem::Specification.new do |spec|
  spec.name          = "dsc_lcm_configuration"
  spec.version       = DscLcmConfiguration::VERSION
  spec.authors       = ["Steven Murawski"]
  spec.email         = ["steven.murawski@gmail.com"]
  spec.license           = "Apache 2"


  spec.summary       = %q{Creates proper LCM configurations for Windows PowerShell DSC.}
  spec.description   = %q{Creates proper LCM configurations for Windows PowerShell DSC.}
  spec.homepage      = "https://github.com/smurawski/dsc_lcm_configuration"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "pry-stack_explorer"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rb-readline"
  spec.add_development_dependency "chefstyle"

end
