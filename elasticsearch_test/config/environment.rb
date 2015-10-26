# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Load the lib/ext files
Dir["#{Rails.root}/lib/ext/**/*.rb"].each { |f| require f }
