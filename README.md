# FreeAgent Coding Challenge

Thank you for your interest in the FreeAgent Coding Challenge.  This template is a barebones guide to get you started.  Please add any gems, folders, files, etc. you see fit in order to produce a solution you're proud of.

## Coding Challenge Instructions

Please see the INSTRUCTIONS.md file for more information.

## Your Solution Setup and Run Instructions

Please include instructions on how to setup and run your solution here.

0. Ensure the following:
```
ruby version 2.4.1 or above
rails version 5.2.3 or above
```

1. Unzip the zip file coding-challenge-template_9May2019_DG.zip:

```
In Linux or MAC terminal Or Windows Command line emulator
unzip coding-challenge-template_9May2019_DG.zip
```

2. CD to the base folder:
```
cd coding-challenge-rails-dg
```

3. Install gems:

```
bundle install
```

4. Run tests:

```
bundle exec ruby test/run_tests.rb
```

5. Start a console session:

```
bundle exec irb -Ilib
```

6. Load the template library:

```
require 'currency_exchange'
```

7. Calculate an exchange rate:

```
CurrencyExchange.rate(Date.new(2018, 11, 22), "USD", "GBP")
CurrencyExchange.rate(Date.new(2018,11,22), "JPY", "EUR")
exit()
```

8. Start the rails server
```
rails s -p 3000 -b 0.0.0.0
```

9. To list the already done currency conversions (log of conversions done)
(To use the rails app, I recommend using POSTMAN Google Chrome Plug;in or command line curl)
```
Postman: GET: http://localhost:3000/api/converters
OR
curl: curl -XGET -H "Content-Type: application/json" 'http://localhost:3000/api/converters'
```

10. To delete a log entry
(To use the rails app, I recommend using POSTMAN Google Chrome Plug;in or command line curl)
```
Postman: DELETE: http://localhost:3000/api/converters/<id>
Please get an example id by listing the already done conversions from step 7
OR
curl: curl -XDELETE -H "Content-Type: application/json" 'http://localhost:3000/api/converters/<id>'
Please get an example id by listing the already done conversions from step 7
```

11. To add another converter / run a currency converter
(To use the rails app, I recommend using POSTMAN Google Chrome Plug;in or command line curl)
```
Postman: POST: http://localhost:3000/api/converters
     and in the HEADERS, "Content-Type: application/json"
     and send the following json in the body:
     {
	  "converter": {
	    "from_currency": "NZD",
	    "to_currency": "CHF",
	    "conversion_date": "2018-07-25"
	  }
	}
OR
curl: curl -XPOST -H "Content-Type: application/json" 'http://localhost:3000/api/converters' 
-d '{"converter": {"from_currency": "GBP","to_currency": "USD", "conversion_date": "2018-07-25"}}'
```

## Your Design Decisions

Below are my thoughts around designing the solution:

1. Test to see what all parts of the solution is already built and not re-invent the wheel
1.1. Since the run_tests.rb and currency_exchange_test.rb were working, I left them unchanged
     but kept in mind to add more tests once I started writing the code
1.2. I checked the Gemfile and it looked good
1.3. The base template for currency_exchange.rb was in place and I found out that it is the only file I 
     needed to code

2. I had ruby 2.2.1 and rails 4.2.3. I wanted to used rails 5.x
2.1. I upgraded ruby to 2.4.1
2.2. I installed rails 5.2.3 (this solution did not need rails but I wanted to go above and beyond 
     and implement the same using rails 5). More on this in a different solution

3. I saw that the EUR currency conversion json file is already provided

4. I decided to use the same module provided in currency_exchange.rb (CurrencyExchange)

5. I wanted to separate functionality into different methods
5.1 I created a method to read the json file along with some exception handling
5.2 I created another method to extract the currency conversion by date
5.3 I kept the rest of the functionality in rate() method but I am sure I could split that functionality
    into more methods
5.4 I did manage to handle a few exception scenarios in each of the methods - I am sure there can be more, if I 
    had more time

6. The expectation was to be able to switch to different source of currency conversion
6.1 For this reason, I split the reading of the json file into its own separate method
6.2 In the future, if you wanted to get that data from another source like an external API, then I can
    write another read method, example read_from_api() and return a json that is consumable by
    get_currency_conversion_by_date() method
6.3 If the source was a db or a flat file, then we can as easily write read_from_db() or read_from_file()
    and return a consumable json

7. The expectation was to be able to switch the base currency from EUR to another one
7.1 For that reason, I made base_currency as an argument into all the methods with `EUR` as default
7.2 If the base currency is different, then the rest of the code should be able to handle the 
    currency converion with any code change based on lines 113 and 115 of the lib/currency_exchange.rb

8. I add a couple more tests to test/currency_exchange_test.rb but I am sure we can add a lot more tests

9. The last time I wrote code in Ruby was a few years ago :)

10. I wanted to put this container inside a rails app

11. I created a rails app
11.1 I copied over currency_exchange files, test files and data files into the rails application structure
11.2 I used sqlite db because it is easy to port

12. Now you can do multiple API operations
12.1 To list all the converters done (log): GET: http://localhost:3000/api/converters
12.2 To add another converter / run a currency converter: POST: http://localhost:3000/api/converters
     and in the HEADERS, "Content-Type: application/json"
     and send the following json in the body:
     {
	  "converter": {
	    "from_currency": "NZD",
	    "to_currency": "CHF",
	    "conversion_date": "2018-07-25"
	  }
	}
     OR use curl: curl -XPOST -H "Content-Type: application/json" 'http://localhost:3000/api/converters' -d '{"converter": {"from_currency": "GBP","to_currency": "USD", "conversion_date": "2018-07-25"}}'
12.3 To delete a log entry: DELETE: http://localhost:3000/api/converters/<id>
     OR use curl: curl -XDELETE -H "Content-Type: application/json" 'http://localhost:3000/api/converters/<id>'

13. Please excuse any typos or skipped words (my mind tends to run a bit faster than my fingers)