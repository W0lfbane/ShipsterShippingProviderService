module SetExchangeRate extend ActiveSupport::Concern

    included do

      monetize :common_rate_cents, with_currency: :usd
      monetize :rate_cents

      before_save :generate_common_rate

      def serializable_hash(options={})
        super(options.merge({
          except: ['rate_cents', 'common_rate_cents']
        })).merge({
          'rate' => self.rate.to_f,
          'common_rate' => self.common_rate.to_f
        })
      end

    end
  
    private
   
    def generate_common_rate
      self.common_rate = self.rate.exchange_to 'USD'
    end
end