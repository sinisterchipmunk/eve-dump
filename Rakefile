require 'rubygems'
gem 'hoe', '>= 2.1.0'
require 'hoe'
require 'fileutils'
require './lib/eve-dump'

Hoe.plugin :newgem
# Hoe.plugin :website
# Hoe.plugin :cucumberfeatures

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.spec 'eve-dump' do
  self.developer 'FIXME full name', 'FIXME email'
  self.post_install_message = 'PostInstall.txt' # TODO remove if post-install message not required
  self.rubyforge_name       = self.name # TODO this is default value
  self.extra_deps           = [['activesupport','>= 2.3.5'],['activerecord', '>= 2.3.5']]
end

require 'newgem/tasks'
Dir['tasks/**/*.rake'].each { |t| load t }

remove_task :default
task :default => :spec #[:spec, :features]
