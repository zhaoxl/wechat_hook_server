require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WechatHookServer
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    

    #默认时间格式
    ::Time::DATE_FORMATS[:default] = "%Y-%m-%d %H:%M:%S"
    #纯年月日格式
    ::Time::DATE_FORMATS[:sort] = "%Y-%m-%d"
    #数字格式
    ::Time::DATE_FORMATS[:d] = "%Y%m%d"
  end
end
