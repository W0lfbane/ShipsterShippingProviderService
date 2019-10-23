module ExchangeRate extend ActiveSupport::Concern

    included do

      monetize :common_rate_cents, with_currency: :usd
      monetize :rate_cents

      before_save :generate_common_rate

    end
  
    private
   
    def generate_common_rate
      self.common_rate = self.rate.as_us_dollar
    end
end