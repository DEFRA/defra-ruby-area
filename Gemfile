# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) { |repo_name| "https://github.com/#{repo_name}" }

# Specify your gem's dependencies in defra_ruby_validators.gemspec
gemspec

gem "defra_ruby_style", "~> 0.4.0"
gem "rake"
gem "rubocop"
gem "simplecov", "~> 0.17.1"

gem "rspec"
# webmock allows stubbing of HTTP requests
gem "webmock"
# step-by-step debugging and stack navigation capabilities to pry using byebug
gem "pry-byebug"

# Shim to load environment variables from a .env file into ENV
gem "dotenv"

# Used to generate changelog
gem "github_changelog_generator"
