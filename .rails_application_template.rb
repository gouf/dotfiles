# Ref: http://guides.rubyonrails.org/rails_application_templates.html

gem_group :doc do
  gem 'yard'
end

gem 'rb-readline'
gem 'slim-rails'

gem 'rails_safe_tasks'
gem 'nprogress-rails'

gem 'therubyracer'
gem 'less-rails'
gem 'bootstrap'
gem 'freeezer'

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
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet'
  gem 'rack-mini-profiler', require: false
end

gem_group :test do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'launchy'
  gem 'mutant-rspec'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'timecop'
end

# works on Rails 4.2(?) or later
after_bundle do
  run 'curl https://www.gitignore.io/api/vim,rails,node > .gitignore'

  # RSpec
  run 'bundle exec guard init rspec'
  run 'bundle exec guard init rubocop'
  run 'echo "--format Fuubar" >> .rspec'

  # nprogress
  run 'echo "//= require nprogress" >> app/assets/javascripts/application.js'
  run 'echo "//= require nprogress-turbolinks" >> app/assets/javascripts/application.js'
  run 'echo "/*" >> app/assets/stylesheets/application.scss'
  run 'echo " *= require nprogress" >> app/assets/stylesheets/application.scss'
  run 'echo " */" >> app/assets/stylesheets/application.scss'

  # bootstrap
  run %(echo "@import 'bootstrap';" >> app/assets/stylesheets/application.scss)
  run %(echo "//= require popper" >> app/assets/javascripts/application.js)
  run %(echo "//= require bootstrap-sprockets" >> app/assets/javascripts/application.js)

  # rubocop
  run 'curl -L https://github.com/gouf/dotfiles/raw/master/.rubocop.yml > .rubocop.yml'
  run 'bundle exec rubocop --auto-correct'
  run 'bundle exec rubocop --auto-gen-config'
  run 'echo "inherit_from:" >> .rubocop.yml'
  run 'echo "  - .rubocop_todo.yml" >> .rubocop.yml'

  # Disable coffee-rails gem
  run "cat Gemfile|ruby -ne 'puts $_ =~ /^(.+coffee-rails.+)$/ ? \"# \#{$1}\" : $_' > out"
  run 'mv out Gemfile'

  # Add bullet gem configure
  run %(head config/environments/development.rb -n -1 > config/environments/tmp && mv config/environments/tmp config/environments/development.rb) # remove last line
  run %(wget https://raw.githubusercontent.com/gouf/dotfiles/master/.bullet_config -O - >> config/environments/development.rb)

  # Init rack-runtime
  run %(bundle exec rails g rack_profiler:install)

  # git
  git :init
  git add: '.'
  git commit: "-a -m 'Initial Commit'"
end
