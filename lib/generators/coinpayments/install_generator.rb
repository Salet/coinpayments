module Coinpayments
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    desc "Creates CoinPayments initializer for your application"

    def copy_initializer
      template "coinpayments_initializer.rb", "config/initializers/coinpayments.rb"
      p "Install complete! You can find your CoinPayments configuration file in config/initializers/coinpayments.rb"
    end
  end
end