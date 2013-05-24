source "https://rubygems.org"

gem "rails", "3.2.13"

group :assets do
  gem "sass-rails",   "~> 3.2.3"
  gem "coffee-rails", "~> 3.2.1"
  gem "uglifier", ">= 1.0.3"
end

group :development, :test do
  gem "sqlite3"
end

# We use Ppostgres in production, because Heroku requires postgres
group :production do
  gem "pg"
end

# gem "activeadmin"
gem "bcrypt-ruby"
gem "haml-rails"
gem "jquery-rails"
gem "simple_form"
# gem "twitter-bootstrap-rails"

# To use Jbuilder templates for JSON
# gem "jbuilder"

# Use unicorn as the app server
# gem "unicorn"

# Deploy with Capistrano
# gem "capistrano"

# To use debugger
# gem "debugger"

# Testing Frameworks
gem "rspec-rails"
group :test do
  # Pretty printed test output
  gem "turn", :require => false 
  gem "factory_girl_rails"
end