class ShippingRate < ApplicationRecord
    require 'csv'

    include SetExchangeRate

    belongs_to :shipping_provider

    validates :origin, length: { is: 2 }, presence: true
    validates :destination, length: { is: 2 }, presence: true
    validates :rate, presence: true

    def self.import_csv(path)
        CSV.foreach(path, headers: true) do |row|
            hashedRow = row.to_hash
            ShippingRate.create!({
                origin: hashedRow['origin'],
                destination: hashedRow['destination'],
                rate: hashedRow['rate'], 
                rate_currency: hashedRow['currency'],
                shipping_provider_id: hashedRow['shipping company id']
            })
        end
    end
end
