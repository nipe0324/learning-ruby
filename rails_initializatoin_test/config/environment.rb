puts 'load config/environment.rb'

# Load the Rails application.
puts 'require_relative "application"'
require_relative "application"

# Initialize the Rails application.
puts 'run Rails.application.initialize!'
Rails.application.initialize!
puts 'after run Rails.application.initialize!'
