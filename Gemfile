source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.1'

# Use sqlite3 as the database for Active Record

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

gem 'jquery-tablesorter'

gem 'anjlab-bootstrap-rails', '~> 3.0.2.0', :require => 'bootstrap-rails'


gem 'faker'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :test, :development do
  gem 'sqlite3'
  gem "rspec-rails"
  gem "capybara"
  gem "selenium-webdriver"
  gem "better_errors"
  gem "binding_of_caller"
  gem "terminal-notifier-guard"
  gem "factory_girl_rails"
  gem "simplecov"
  gem "database_cleaner"
  gem "guard", ">=2.1.0"
  gem "guard-rspec"
end




=begin
on directory page of lobbyist firms
scrape each row,get the href, append "http://www.nyc.gov/lobbyistsearch/" to the beginning and "&op=&pg_l=1" to the end

open each href scraped above

run below loop/scrape for each href

pages = "how many pages returned from search"

pages.times do |n|
  break if done
  open-uri get page "url_string#{n}"

  parse rows
  for each row
    import if relevent (according to levenstein/percent algorithm)
  else 
    dont import and set done = true
  end
end

 
gem install levenshtein
Levenshtein.distance('AMERICAN CANCER SOCIETY, INC.'.downcase, 'Geto & de Milly Inc.'.downcase)
=> 18
'Geto & de Milly Inc.'.length
=> 20
18.0/20
=> .9
if this perecent is greater than 40%, then don't include in srape

=end



