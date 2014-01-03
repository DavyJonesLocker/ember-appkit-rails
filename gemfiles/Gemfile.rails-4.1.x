source "https://rubygems.org"

gemspec path: '../'

gem 'rails', '~>4.1.0.beta.1'

group :development, :test do
  gem 'pry'
  gem 'm'
  gem 'byebug'
end
