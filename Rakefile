require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

require "chefstyle"
require "rubocop/rake_task"
RuboCop::RakeTask.new do |task|
  task.options << "--display-cop-names"
end

begin
  require "github_changelog_generator/task"
  require "dsc_lcm_configuration/version"

  GitHubChangelogGenerator::RakeTask.new :changelog do |config|
    config.future_release = "v#{DscLcmConfiguration::VERSION}"
    config.pulls = true
    config.issues = false
    config.user = "smurawski"
    config.project = "dsc_lcm_configuration"
  end
rescue LoadError
  puts "github_changelog_generator is not available." \
       " gem install github_changelog_generator to generate changelogs"
end
