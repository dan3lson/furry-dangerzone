source 'https://rubygems.org'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Bootstrap (http://getbootstrap.com)
gem 'bootstrap-sass', '~> 3.3.5'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Solves the problems of setting project-specific environment vars
gem 'dotenv-rails'
# Makes http fun again
gem 'httparty'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Pagination
gem 'will_paginate', '~> 3.0.6'
gem 'will_paginate-bootstrap'
# Remove the .3 second delay mobile browsers have
gem 'fastclick-rails'
# Adds cool, scalable fonts (mainly to replace glyphicons)
gem "font-awesome-rails"

group :development do
  gem "bullet"
  gem 'meta_request'
end

group :test do
  gem 'database_cleaner'
  # A library for setting up Ruby objects as test data. (https://github.com/thoughtbot/factory_girl)
  gem 'poltergeist'
  # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
end

group :development, :test do
  # Acceptance test framework for web applications. (https://github.com/jnicklas/capybara)
  gem 'capybara'
  # Ensures a clean state during tests
  gem 'factory_girl'
  # Enables you to use fake people, places, or things (e.g. addresses)
  gem 'faker'
  # Saves and opens a page for when debugging tests
  gem 'launchy'
  # Headless driver for capybara testing based on PhantomJS
  gem 'pry-rails'
  # Rspec is used for Bheavior Driven Development (http://rspec.info, https://github.com/rspec/rspec)
  gem 'rspec-rails', '~> 3.0'
  # Aids in unit testing relationships (https://github.com/thoughtbot/shoulda-matchers)
  gem "shoulda-matchers"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
end

group :production do
  gem 'puma', '2.11.1'
  gem 'rails_12factor', '0.0.2'
end

ruby '2.0.0'
