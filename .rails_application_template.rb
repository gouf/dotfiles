# Ref: http://guides.rubyonrails.org/rails_application_templates.html

gem_group :doc do
  gem 'yard'
end

gem 'rb-readline'
gem 'slim-rails'

gem 'rails_safe_tasks'
gem 'nprogress-rails'

gem 'bootstrap'
gem 'freeezer'

gem_group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rubocop', require: false
  gem 'squasher'
end

gem_group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'launchy'
  gem 'mutant-rspec'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'timecop'
end

gem_group :test, :development do
  gem 'fuubar'
end

# works on Rails 4.2(?) or later
after_bundle do
  run 'curl https://www.gitignore.io/api/vim,rails,node > .gitignore'

  # RSpec
  run 'bundle exec guard init rspec'
  run %(yes | bundle exec rails generate rspec:install)
  run 'echo "--format Fuubar" >> .rspec'

  # rubocop
  run 'curl -L https://github.com/gouf/dotfiles/raw/master/.rubocop.yml > .rubocop.yml'
  run 'bundle exec rubocop --auto-correct'
  run 'bundle exec rubocop --auto-gen-config'
  run 'echo "inherit_from:" >> .rubocop.yml'
  run 'echo "  - .rubocop_todo.yml" >> .rubocop.yml'

  # git
  git :init
  git add: '.'
  git commit: "-a -m 'Initial Commit'"
end
