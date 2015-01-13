require_relative "coinpayments/version"
require_relative "coinpayments/configuration"
require "hashie/mash"
require "httparty"


module Coinpayments

  class << self
    attr_accessor :configuration
  end

  public
    def self.configure
      yield(configuration) if block_given?
    end


  private
    def self.configuration
      @configuration ||=  Configuration.new
    end    

    def self.required_params
      { version: configuration.version, key: configuration.public_api_key }
    end

    def self.hmac(body)
      OpenSSL::HMAC.hexdigest(OpenSSL::Digest::Digest.new('sha512'), configuration.private_api_key, HTTParty::HashConversions.to_params(body))
    end

    def self.api_call(args)
      body = required_params.merge!(cmd: caller[0][/`.*'/][1..-2]).merge!(args)
      response = HTTParty.post(configuration.base_uri, body: body, headers: {'hmac' => hmac(body)})
      response['error'] == 'ok' ? Hashie::Mash.new(response['result']) : response['error']
    end


  public
    def self.rates(options = {})
      api_call(options)
    end

    def self.balances(options = {})
      api_call(options)
    end

    def self.create_transaction(amount, currency1, currency2, options = {})
      args = { amount: amount, currency1: currency1, currency2: currency2 }.merge!(options)
      api_call(args)
    end

    def self.create_withdrawal(amount, currency, address, options = {})
      args = { amount: amount, currency: currency, address: address }.merge!(options)
      api_call(args)
    end

    def self.get_tx_info(txid)  
      args = { txid: txid }
      api_call(args)
    end

    def self.get_withdrawal_info(id)
      args = { id: id }
      api_call(args)
    end

end
