class MonetizeShippingProviders < ActiveRecord::Migration[6.0]
  def change
    add_money :shipping_providers, :rate
    add_money :shipping_providers, :common_rate
  end
end
