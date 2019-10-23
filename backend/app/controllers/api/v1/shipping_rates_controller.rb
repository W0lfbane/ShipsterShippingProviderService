class Api::V1::ShippingRatesController < Api::V1::ResourceController

  private

    # Only allow a trusted parameter "white list" through.
    def shipping_rate_params
      params.require(:shipping_rate).permit(:origin, :destination, :rate, :rate_currency, :shipping_provider_id)
    end
end