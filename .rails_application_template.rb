# Ref: http://guides.rubyonrails.org/rails_application_templates.html

gem_group :doc do
  gem 'yard'
end

gem_group :development do
  gem 'rubocop', require: false
  gem 'guard'
  gem 'guard-rubocop'
  gem 'guard-rspec'
  gem 'guard-rails_best_practices'
end

gem_group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'fuubar'
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

  git :init
  git add: '.'
  git commit: "-a -m 'Initial Commit'"
end
