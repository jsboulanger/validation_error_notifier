require 'rubygems'

ENV["RAILS_ENV"] ||= 'test'

RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
end
require File.expand_path("../dummy/config/environment.rb", __FILE__)
require File.expand_path("../dummy/spec/spec_helper.rb", __FILE__)

require 'validation_error_notifier'
