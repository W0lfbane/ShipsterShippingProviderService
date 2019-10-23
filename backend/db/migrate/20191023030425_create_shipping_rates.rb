class CreateShippingRates < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_rates do |t|
      t.string :origin, null: false, length: 2
      t.string :destination, null: false, length: 2
      t.references :shipping_provider, null: false, foreign_key: true

      t.timestamps
    end
  end
end
