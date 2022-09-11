# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SroThp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    def my_add_to_load_paths(path)
      if Rails.env.production? #|| Rails.env.development?
        config.eager_load_paths << path
      else
        config.autoload_paths << path
      end
    end

    my_add_to_load_paths Rails.root.join('lib/lib')

    config.action_controller.include_all_helpers = false
  end
end
