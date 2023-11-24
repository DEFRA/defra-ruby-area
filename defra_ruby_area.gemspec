# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem"s version:
require "defra_ruby/area/version"

Gem::Specification.new do |spec|
  spec.name          = "defra_ruby_area"
  spec.version       = DefraRuby::Area::VERSION
  spec.authors       = ["Defra"]
  spec.email         = ["alan.cruikshanks@environment-agency.gov.uk"]
  spec.license       = "The Open Government Licence (OGL) Version 3"
  spec.homepage      = "https://github.com/DEFRA/defra-ruby-area"
  spec.summary       = "Defra ruby on rails EA administrative area lookup"
  spec.description   = "Use to query the EA's administrative boundary Web Feature Services for area names."
  spec.required_ruby_version = ">= 3.2"

  spec.files = Dir["{bin,config,lib}/**/*", "LICENSE", "Rakefile", "README.md"]

  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
          "public gem pushes."
  end

  # The response from the area WFS services is in XML so we need Nokogiri to
  # parse it
  spec.add_dependency "nokogiri", ">= 1.13.2"

  # Use rest-client for external requests, eg. to Companies House
  spec.add_dependency "rest-client", "~> 2.0"
end
