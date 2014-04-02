# Set up gems listed in the Gemfile.
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Load the custom environment variables.
begin
  require File.expand_path('../environment_variables', __FILE__)
rescue LoadError; end
