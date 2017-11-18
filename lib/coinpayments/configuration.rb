module Coinpayments
  class Configuration
    attr_accessor :version, :base_uri, :merchant_id, :public_api_key, :private_api_key, :secret_phrase

    def initialize
      @version = 1
      @base_uri = 'https://www.coinpayments.net/api.php'
      @merchant_id = ''
      @public_api_key = ''
      @private_api_key = ''
      @secret_phrase = ''
    end
  end
end
