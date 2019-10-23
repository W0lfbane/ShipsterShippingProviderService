class Api::V1::ShippingProvidersController < Api::V1::ResourceController

  private

    # Only allow a trusted parameter "white list" through.
    def shipping_provider_params
      params.require(:shipping_provider).permit(:company, :rate, :rate_currency)
    end
end
