require "json"
require "date"
require "custom_exception"
require "parsedate"
require "Date"

module CurrencyExchange

  # Return the content of EUR conversion json file
  # Raises an exception if the file is not found
  # Raises an exception if the file is not parsed properly
  # ==== Examples
  # 
  # CurrencyExchange.read_json()
  # CurrencyExchange.read_json("data")
  # CurrencyExchange.read_json("data", "/eurofxref-hist-90d.json")
  # CurrencyExchange.read_json("data", "/eurofxref-hist-90d.json", "EUR")
  def self.read_json(base_currency = "EUR", data_dir = "data", file_name = "/eurofxref-hist-90d.json")

    # Get the base directory
    base_dir = File.expand_path(File.join(File.dirname(__FILE__), ".."))
    # Get file directory based on base directory and the data folder
	file_dir  = File.join(base_dir, data_dir)

	begin
		# if base currency is EUR
		if base_currency == "EUR"
			# read the EUR conversion currency data
			currency_file = File.read(file_dir+file_name)
		end
		if currency_file
			p "Currency file read successfuly"
		end
	rescue
		p "Currency file not found or read properly"
		currency_file = File.read(file_dir+"/eurofxref-hist-90d.json")
		retry
	end

	begin
		# parse the file into currency_data to be available for use
	    currency_data = JSON.parse(currency_file)
	    if currency_data
	    	p "Currency file parsed successfuly"
	    end
	rescue JSON::ParserError
		puts "Failed to parse the Currency file"
		currency_data = JSON.parse({})
	end

	# return currency_data
	currency_data

  end

  # Return the EUR currency conversion for a specific date
  # Returns 0000-00-00 if provided date is not found
  # ==== Examples
  # 
  # CurrencyExchange.get_currency_conversion_by_date("2018-11-22")
  # CurrencyExchange.get_currency_conversion_by_date("2018-11-22", "EUR")
  # CurrencyExchange.get_currency_conversion_by_date()
  def self.get_currency_conversion_by_date(date = "2018-11-22", base_currency = "EUR")

  	# validate date format
  	date_check = ParseDate.parsedate date, true

  	begin
	  	# check if date greater than 2000
	  	if date_check[0] < 2000
	  		raise CustomException.new "Date provided is before year 2000"
	  	end

		# check if date is today or earlier
		if Date.parse(date_check[0].to_s + '-' + date_check[1].to_s + '-' + date_check[2].to_s) > Date.today
			raise CustomException.new "Date provided is after today"
		end

	rescue CustomException => e
		return "0000-00-00"
	end

  	# read currency conversion json
  	currency_data = self.read_json(base_currency)

	# return EUR currency conversion for a specific date
	if currency_data[date]
		return currency_data[date]
  	else
  		return "0000-00-00"
  	end

  end

  # Return the exchange rate between from_currency and to_currency on date as a float.
  # Raises an exception if unable to calculate requested rate.
  # Raises an exception if there is no rate for the date provided.
  # ==== Examples
  # 
  # CurrencyExchange.rate(Date.new(2018,11,22), "GBP", "USD")
  # CurrencyExchange.rate(Date.new(2018,11,22), "JPY", "EUR")
  # CurrencyExchange.rate(Date.new(2018,11,22), "JPY", "USD", "EUR")
  # CurrencyExchange.rate(Date.new(2018,11,22))
  def self.rate(date = nil, from_currency = nil, to_currency = nil, base_currency = "EUR")

    begin
	    # return nil if date is not provided
	    if date == nil
	    	raise CustomException.new "date not provided"
	    elif from_currency == nil
	    	raise CustomException.new "from_currency not provided"
	    elif to_currency == nil
	    	raise CustomException.new "to_currency not provided"
	    end
	rescue CustomException => e
		return e.message
	end
    # calculate and return rate
    # return exception message if there are any errors in calculation
    begin
	    currency_data_date = self.get_currency_conversion_by_date(date.strftime("%Y-%m-%d"), base_currency)
	    if currency_data_date == "0000-00-00"
	    	# return a message that there is no rate for the date provided
	    	raise CustomException.new "EUR currency conversion rate for the provided date is not found"
		end
	rescue CustomException => e
		return e.message
	end
	# calculate and return rate
    # return exception message if there are any errors in calculation
	begin
	 	# get currency rate for the from_currency
	    from_currency_rate = (from_currency == base_currency) ? 1 : currency_data_date[from_currency]
	    # get currency rate for the to_currency
	    to_currency_rate = (to_currency == base_currency) ? 1 : currency_data_date[to_currency]
	    # currency conversion by division of to_currency_date / from_currency_date as a float
	    return to_currency_rate / from_currency_rate
	rescue
		return "Unable to calculate requested rate"
	end
  end

end
