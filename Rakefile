require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

Rake::TestTask.new(:ios) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/ios/**/*_test.rb']
end

Rake::TestTask.new(:android) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/android/**/*_test.rb']
end

task :default => :test
