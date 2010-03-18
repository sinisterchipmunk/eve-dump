unless defined?(Gem)
  require 'rubygems'
  gem 'activerecord',  '>= 2.3.5'
  gem 'activesupport', '>= 2.3.5'
  gem 'sc-core-ext',   '>= 1.0.0'
end

require 'active_record'
require 'active_support'
require 'sc-core-ext'

gem_path = File.expand_path(File.dirname(__FILE__))
$LOAD_PATH.unshift gem_path
ActiveSupport::Dependencies.load_paths.unshift gem_path
ActiveSupport::Dependencies.load_once_paths.unshift gem_path
