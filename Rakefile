require 'rdoc/task'
require 'net/http'
require 'uri'

begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'EmberAppKit'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../test/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

desc "Update ember-resolver."
task :update_resolver do
  uri = URI("https://raw.github.com/stefanpenner/ember-jj-abrams-resolver/master/dist/ember-resolver.js")

  output = StringIO.new
  output.puts "// Fetched from: " + uri.to_s
  output.puts "// Fetched on: " + Time.now.utc.iso8601.to_s
  output.puts Net::HTTP.get(uri).force_encoding("UTF-8")
  output.rewind

  File.write('vendor/assets/javascripts/ember-appkit/resolver.js', output.read)
end

desc "Updates the resolver when UPDATE_RESOLVER is set."
task :update_resolver_if_requested do
  Rake::Task['update_resolver'].invoke if ENV['UPDATE_RESOLVER'] == 'true'
end

Bundler::GemHelper.install_tasks

require 'rake/testtask'

Rake::TestTask.new(:integration_test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/integration/**/*_test.rb'
  t.verbose = false
end

Rake::TestTask.new(:generators_test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/generators/**/*_test.rb'
  t.verbose = false
end

task :test => [:update_resolver_if_requested, :generators_test, :integration_test]

task default: :test
