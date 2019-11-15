# http://test-unit.github.io/
require 'test/unit'
require 'currency_exchange'
require 'date'

class CurrencyExchangeTest < Test::Unit::TestCase
  def setup
  end

  def test_non_base_currency_exchange_is_correct
    correct_rate = 1.2870493690602498
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "GBP", "USD")
  end

  def test_base_currency_exchange_is_correct
    correct_rate = 0.007763975155279502
    assert_equal correct_rate, CurrencyExchange.rate(Date.new(2018,11,22), "JPY", "EUR")
  end

  def test_non_date_provided_not_found
    assert_equal "EUR currency conversion rate for the provided date is not found", CurrencyExchange.rate(Date.new(2019,11,22), "GBP", "USD")
  end

  def test_date_not_provided
    assert_equal "date not provided", CurrencyExchange.rate()
  end

  def test_date_before_2000
    assert_equal "EUR currency conversion rate for the provided date is not found", CurrencyExchange.rate(Date.new(1999,11,22), "GBP", "USD")
  end

  def test_date_after_today
    assert_equal "EUR currency conversion rate for the provided date is not found", CurrencyExchange.rate(Date.new(2019,11,22), "GBP", "USD")
  end
end
