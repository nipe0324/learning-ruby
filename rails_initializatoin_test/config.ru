puts "config.ru"
# This file is used by Rack-based servers to start the application.

puts 'require_relative "config/environment"'
require_relative "config/environment"

puts 'run Rails.application'
run Rails.application
puts 'Rails.application.load_server'

app = Rails.application
app.load_server
