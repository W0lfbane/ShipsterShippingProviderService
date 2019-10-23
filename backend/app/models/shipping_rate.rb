class ShippingRate < ApplicationRecord
    include SetExchangeRate

    belongs_to :shipping_provider

    validates :origin, length: { maximum: 2 }, presence: true
    validates :destination, length: { maximum: 2 }, presence: true
    validates :rate, presence: true
end
