module ExchangeRate extend ActiveSupport::Concern

    included do

      monetize :common_rate_cents, with_currency: :usd
      monetize :rate_cents

      before_save :generate_common_rate

      def as_json(options={})
        super(options.merge({
          except: ['rate_cents', 'rate_currency', 'common_rate_cents', 'common_rate_currency']
        })).merge({
          'rate' => self.rate.to_f,
          'currency' => self.rate.currency.to_s,
        })
      end

    end
  
    private
   
    def generate_common_rate
      self.common_rate = self.rate.exchange_to 'USD'
    end
end