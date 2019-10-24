class ShippingProvider < ApplicationRecord
    require 'csv'

    include SetExchangeRate

    has_many :shipping_rates, dependent: :destroy

    validates :company, presence: true
    validates :rate, numericality: { greater_than: 0 }, presence: true
    validates :rate_currency, presence: true

    def self.import_csv(path)
        CSV.foreach(path, headers: true) do |row|
            hashedRow = row.to_hash
            ShippingProvider.create!({
                id: hashedRow['id'],
                company: hashedRow['name'],
                rate: hashedRow['flat shipping rate'], 
                rate_currency: hashedRow['currency']
            })
        end
    end
end
