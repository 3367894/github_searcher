# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra'
gem 'pry'
gem 'require_all'
gem 'haml'
gem 'faraday'
gem 'oj'
gem 'sinatra-param'

group :test, :development do
  gem 'pry-byebug'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'webmock'
end
