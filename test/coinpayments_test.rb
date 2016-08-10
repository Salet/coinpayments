require_relative "../lib/coinpayments"
require "minitest/autorun"
require "pry"
require "webmock/minitest"
require "vcr"


class CoinpaymentsTest < Minitest::Test

  VCR.configure do |c|
    c.cassette_library_dir = "test/fixtures"
    c.hook_into :webmock
  end

  def test_rates
    VCR.use_cassette('rates') do
      r = Coinpayments.rates
      assert r.kind_of?(Hash)
      assert r.respond_to?(:BTC)
    end
  end

  def test_balances
    VCR.use_cassette('balances') do
      r = Coinpayments.balances
      assert r.kind_of?(String)
    end
  end

  def test_create_transaction
    VCR.use_cassette('create_transaction') do
      r = Coinpayments.create_transaction(1, 'GBP', 'START')
      assert r.kind_of?(Hash)
      assert r.respond_to?(:address)
    end
  end

  def test_create_withdrawal
    VCR.use_cassette('create_withdrawal') do
      r = Coinpayments.create_withdrawal(1, 'START', 'sYo5A4vVBBV2SYbh7jPjocqg9DeNYqkP4U')
      assert r.kind_of?(String)
    end
  end

  def test_get_tx_info
    VCR.use_cassette('get_tx_info') do
      r = Coinpayments.get_tx_info('705565b8b8f068566fed1a71977ece30265c6e80cf7dfe854ab4a455701129bc')
      assert r.kind_of?(Hash)
      assert r.respond_to?(:status_text)
    end
  end

  def test_get_callback_address
    VCR.use_cassette('get_callback_address') do
      r = Coinpayments.get_callback_address('BTC')
      assert r.kind_of?(Hash)
      assert r.respond_to?(:address)
    end
  end

  def test_get_withdrawal_info
    VCR.use_cassette('get_withdrawal_info') do
      r = Coinpayments.get_withdrawal_info('705565b8b8f068566fed1a71977ece30265c6e80cf7dfe854ab4a455701129bc')
      assert r.kind_of?(Hash)
      assert r.respond_to?(:status_text)
    end
  end
end
