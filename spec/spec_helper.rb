$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'rspec'
require 'authority'
require 'pry-byebug'
require 'pry'

Authority.configure

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = :random
end
