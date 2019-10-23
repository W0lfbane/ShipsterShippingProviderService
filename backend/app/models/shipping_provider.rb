class ShippingProvider < ApplicationRecord
    include SetExchangeRate

    has_many :shipping_rates, dependent: :destroy

    validates :company, presence: true
    validates :rate, presence: true
end
