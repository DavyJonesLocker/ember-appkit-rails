source "https://rubygems.org"

gemspec path: '../'

gem 'rails', '4.0.3'

group :development, :test do
  gem 'pry'
  gem 'm'
  gem 'byebug'
end
