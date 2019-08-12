require 'rack/test'
require 'rspec'
require 'webmock/rspec'
require "./config/environment"

ENV['RACK_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
