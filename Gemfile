source 'https://rubygems.org'

gem 'rails', '4.1.1'
gem 'haml'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'bootstrap-sass', '>=3.3'
gem 'devise'
gem 'pundit'
gem 'simple_form', '>=3.1'
gem 'cocoon'
gem 'paperclip'
gem 'workflow'
gem 'attr_encrypted'
gem 'kaminari'

group :development do
  gem 'byebug'
  gem 'spring'
  gem 'better_errors'
  gem 'binding_of_caller', :platforms=>[:mri_21]
  gem 'guard-bundler'
  # gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-shell'
  gem 'hub', :require=>nil
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'rb-fchange', :require=>false
  gem 'rb-fsevent', :require=>false
  gem 'rb-inotify', :require=>false
  gem 'capistrano', '~> 3.2.1'
  gem 'capistrano-rails', '~> 1.1'
  gem 'capistrano-bundler', '~> 1.1.2'
  gem 'capistrano-rbenv', '~> 2.0.2'
end
group :development, :test do
  gem 'sqlite3'
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'rspec-rails'
  gem 'thin'
  gem 'faker'
end
group :production do
  gem 'unicorn'
  gem 'pg'
end
group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver', '>=2.45.0.dev3' #pined to workaround firefox 35 bug breaking tests
  gem 'shoulda-matchers', require: false
  gem 'poltergeist'
end
