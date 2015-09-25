# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'eventbrite_contacts/version'

Gem::Specification.new do |spec|
  spec.name          = "eventbrite_contacts"
  spec.version       = EventbriteContacts::Client::VERSION
  spec.authors       = ["Ciaran Lofts"]
  spec.email         = ["ciaran@wishpond.com"]
  spec.description   = %q{Create and remove Eventbrite contacts}

  spec.summary       = %q{Interact with the Eventbrite API to create Contact Lists and retrieve, create and delete Contacts}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  end

  spec.add_dependency 'httparty'
  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
end
