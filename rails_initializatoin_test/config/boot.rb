puts "Load config/boot.rb file"
ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../Gemfile", __dir__)

puts "defined?(Jbuilder) = #{defined?(Jbuilder)}"

puts 'require "bundler/setup"'
require "bundler/setup" # Set up gems listed in the Gemfile.
puts 'require "bootsnap/setup"'
require "bootsnap/setup" # Speed up boot time by caching expensive operations.

puts "defined?(Jbuilder) = #{defined?(Jbuilder)}"
