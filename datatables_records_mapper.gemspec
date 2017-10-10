# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "datatables_records_mapper/version"

Gem::Specification.new do |spec|
  spec.name          = "datatables_records_mapper"
  spec.version       = DatatablesRecordsMapper::VERSION
  spec.authors       = ["klismannsm"]
  spec.email         = ["klismannsm@gmail.com"]

  spec.summary       = 'Map records to a format used by jquery datatables plugin'
  spec.description   = 'This gem interprets the parameters passed by the ajax call made by the datatables plugin and returns the requested records'
  spec.homepage      = 'https://github.com/klismannsm/datatables_records_mapper'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "shoulda-matchers"
  spec.add_development_dependency "pry"
  spec.add_dependency "activemodel", "~> 4.2.6"
end
