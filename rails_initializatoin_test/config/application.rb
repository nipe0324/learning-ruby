puts 'load config/application.rb'
puts 'require_relative "boot"'
require_relative "boot"

# 各railtie内でinitializerが呼ばれて初期化処理の登録がされる
# 初期化処理の実行自体はRails.application.initialize!で行われる
puts 'require "rails/all"'
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
puts 'run Bundler.require(*Rails.groups)'
# ここでGemがロードされる
Bundler.require(*Rails.groups)

module RailsInitializatoinTest
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
