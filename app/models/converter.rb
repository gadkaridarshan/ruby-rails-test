class Converter < ApplicationRecord
	validates :from_currency, :to_currency, presence: true
end
