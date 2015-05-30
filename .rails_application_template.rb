# Ref: http://guides.rubyonrails.org/rails_application_templates.html

gem_group :doc do
  gem 'yard'
end

gem 'rb-readline'
gem 'slim-rails'

gem 'rails_safe_tasks'
gem 'nprogress-rails'

gem_group :development do
  gem 'rubocop', require: false
  gem 'guard'
  gem 'guard-rubocop'
  gem 'guard-rspec'
  gem 'pry-rails'
  gem 'pry-coolline'
  gem 'pry-byebug'
  gem 'annotate'
  gem 'squasher'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'fuubar'
  gem 'timecop'
end

gem_group :test do
  gem 'timecop'
  gem 'faker'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
end

# works on Rails 4.2(?) or later
after_bundle do
  run 'mv README.rdoc README.md'
  run 'curl https://www.gitignore.io/api/vim,rails > .gitignore'
  run 'curl -L https://github.com/gouf/dotfiles/raw/master/.rubocop.yml > .rubocop.yml'
  run 'bundle exec guard init rspec'
  run 'bundle exec guard init rails_best_practices'
  run 'bundle exec guard init rubocop'
  run 'bundle exec rails generate rspec:install'
  # nprogress
  run 'echo "//= require nprogress" >> app/assets/javascripts/application.js'
  run 'echo "//= require nprogress-turbolinks" >> app/assets/javascripts/application.js'
  run 'echo "/*" >> app/assets/stylesheets/application.css'
  run 'echo " *= require nprogress" >> app/assets/stylesheets/application.css'
  run 'echo " */" >> app/assets/stylesheets/application.css'

  git :init
  git add: '.'
  git commit: "-a -m 'Initial Commit'"
end
