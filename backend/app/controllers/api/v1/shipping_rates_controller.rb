module Api
  module V1
    class ShippingRatesController < ApplicationController
      before_action :set_shipping_rate, only: [:show, :update, :destroy]

      # GET /shipping_rates
      def index
        @shipping_rates = ShippingRate.all

        render json: @shipping_rates
      end

      # GET /shipping_rates/1
      def show
        render json: @shipping_rate
      end

      # POST /shipping_rates
      def create
        @shipping_rate = ShippingRate.new(shipping_rate_params.slice(:origin, :destination, :shipping_provider_id))
        @shipping_rate.rate = Money.from_amount(shipping_rate_params.rate, shipping_rate_params.currency)

        if @shipping_rate.save
          render json: @shipping_rate, status: :created, location: @shipping_rate
        else
          render json: @shipping_rate.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /shipping_rates/1
      def update
        @shipping_rate.rate = Money.from_amount(shipping_rate_params.rate, shipping_rate_params.currency)

        if @shipping_rate.update(shipping_rate_params.slice(:origin, :destination, :shipping_provider_id))
          render json: @shipping_rate
        else
          render json: @shipping_rate.errors, status: :unprocessable_entity
        end
      end

      # DELETE /shipping_rates/1
      def destroy
        @shipping_rate.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_shipping_rate
          @shipping_rate = ShippingRate.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def shipping_rate_params
          params.require(:shipping_rate).permit(:origin, :destination, :rate, :currency, :shipping_provider_id)
        end
    end
  end
end