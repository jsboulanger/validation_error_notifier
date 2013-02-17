require 'rspec/core/rake_task'

unless File.exists? "spec/dummy/db/test.sqlite3"
  sh "cd spec/dummy; bundle exec rake db:migrate; bundle exec rake db:test:prepare; cd ../../;"
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec
