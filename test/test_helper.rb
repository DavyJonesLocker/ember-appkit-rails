# Configure Rails Environment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require 'capybara/rails'
require 'capybara/poltergeist'
require 'byebug'

Capybara.current_driver = :poltergeist

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

class ActionDispatch::IntegrationTest
  include Capybara::DSL
end
