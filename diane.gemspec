
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "diane/version"

Gem::Specification.new do |spec|
  spec.name          = "diane"
  spec.version       = Diane::VERSION
  spec.authors       = ["mnyrop"]
  spec.email         = ["m.nyrop@columbia.edu"]

  spec.summary       = %q{CL gem for recording and playing back thoughts/intel/motivations without bloating the Git logs.}
  spec.description   = %q{I have been assigned a secretary. Her name is Diane. She seems an interesting cross between a saint and a cabaret singer.}
  spec.homepage      = "https://github.com/mnyrop/diane"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.executables   = ["diane"]
  spec.require_paths = ["lib"]

  spec.add_dependency "mercenary", "~> 0.3"
  spec.add_dependency "colorize", "~> 0.3"
  spec.add_development_dependency "bundler", "~> 1.16"
end
