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

  spec.files = Dir["{bin,config,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  spec.test_files = Dir["spec/**/*"]

  spec.require_paths = ["lib"]

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
  spec.add_dependency "nokogiri", "~> 1.10.7"

  # Use rest-client for external requests, eg. to Companies House
  spec.add_dependency "rest-client", "~> 2.0"

  spec.add_development_dependency "defra_ruby_style"
  # Shim to load environment variables from a .env file into ENV
  spec.add_development_dependency "dotenv"
  # Allows us to automatically generate the change log from the tags, issues,
  # labels and pull requests on GitHub. Added as a dependency so all dev's have
  # access to it to generate a log, and so they are using the same version.
  # New dev's should first create GitHub personal app token and add it to their
  # ~/.bash_profile (or equivalent)
  # https://github.com/skywinder/github-changelog-generator#github-token
  spec.add_development_dependency "github_changelog_generator"
  # Adds step-by-step debugging and stack navigation capabilities to pry using
  # byebug
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "simplecov", "~> 0.17.1"
  spec.add_development_dependency "vcr", "~> 5.0"
  spec.add_development_dependency "webmock", "~> 3.4"
end
