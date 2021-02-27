# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Essentials
gem 'bootsnap', require: false
gem 'pg', '~> 1.1'
gem 'puma'
gem 'rails', '~> 6.1.3'

# API development
gem 'grape'
gem 'grape-swagger'
gem 'grape-swagger-rails'

# Authentication
gem 'devise'
gem 'devise-jwt'

group :development, :test do
  # Debugging
  gem 'byebug'
  gem 'pry-byebug'
  gem 'pry-rails'

  # Code style check
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false

  # Testing
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
