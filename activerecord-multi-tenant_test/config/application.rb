require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ActiverecordMultiTenantTest
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

    initializer "active_record.hogehoge" do
      ActiveSupport.on_load(:active_record) do
        puts  "active_record.hogehoge"
      end
    end
  end
end
# Set Rails.application.config.filter_parameters
# active_record.hogehoge
