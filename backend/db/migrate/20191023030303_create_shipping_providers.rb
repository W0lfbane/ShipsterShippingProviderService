class CreateShippingProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :shipping_providers do |t|
      t.string :company, null: false

      t.timestamps
    end
  end
end
