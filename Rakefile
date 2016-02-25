#!/usr/bin/env rake
require "bundler/gem_tasks"
require "bundler/gem_tasks"
require 'cucumber'
require 'cucumber/rake/task'

Cucumber::Rake::Task.new :features

task :jenkins do
  require 'fileutils'
  FileUtils.rm_rf 'features/reports'
  Cucumber::Rake::Task.new do |t|
    t.cucumber_opts = "--tags ~@real-api --format pretty --format junit --out features/reports"
  end.runner.run
end
