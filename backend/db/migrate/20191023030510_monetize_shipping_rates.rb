class MonetizeShippingRates < ActiveRecord::Migration[6.0]
  def change
    add_money :shipping_rates, :rate
    add_money :shipping_rates, :common_rate
  end
end
