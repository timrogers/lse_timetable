# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lse_timetable/version'

Gem::Specification.new do |spec|
  spec.name          = "lse_timetable"
  spec.version       = LseTimetable::VERSION
  spec.authors       = ["Tim Rogers"]
  spec.email         = ["me@timrogers.co.uk"]
  spec.summary       = %q{Access student timetables at the London School of Economics and Political Science (LSE)}
  spec.description   = %q{Access student timetables at the London School of Economics and Political Science (LSE)}
  spec.homepage      = "http://timrogers.co.uk"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 1.7"
end
