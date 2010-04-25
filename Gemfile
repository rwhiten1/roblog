# Edit this Gemfile to bundle your application's dependencies.
source 'http://gemcutter.org'


gem "rails", "3.0.0.beta"

## Bundle edge rails:
# gem "rails", :git => "git://github.com/rails/rails.git"

gem "mysql"

## Bundle the gems you use:
# gem "bj"
# gem "hpricot", "0.6"
# gem "sqlite3-ruby", :require => "sqlite3"
# gem "aws-s3", :require => "aws/s3"
gem "RedCloth"

## Bundle gems used only in certain environments:
# gem "rspec", :group => :test
group :test do
	gem "rspec"
	gem "rspec-rails", ">= 2.0.0.beta.1"
	gem "cucumber-rails"
	#gem "webrat"
	gem 'capybara', :git => 'git://github.com/jnicklas/capybara.git'
	gem 'database_cleaner', :git => 'git://github.com/bmabey/database_cleaner.git'
	gem "factory_girl", :git => "git://github.com/thoughtbot/factory_girl.git", :branch => "rails3"
end
