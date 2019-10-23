module Api
  module V1
    class ShippingProvidersController < ApplicationController
      before_action :set_shipping_provider, only: [:show, :update, :destroy]

      # GET /shipping_providers
      def index
        @shipping_providers = ShippingProvider.all

        render json: @shipping_providers
      end

      # GET /shipping_providers/1
      def show
        render json: @shipping_provider
      end

      # POST /shipping_providers
      def create
        @shipping_provider = ShippingProvider.new(shipping_provider_params)

        if @shipping_provider.save
          render json: @shipping_provider, status: :created, location: @shipping_provider
        else
          render json: @shipping_provider.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /shipping_providers/1
      def update
        if @shipping_provider.update(shipping_provider_params)
          render json: @shipping_provider
        else
          render json: @shipping_provider.errors, status: :unprocessable_entity
        end
      end

      # DELETE /shipping_providers/1
      def destroy
        @shipping_provider.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_shipping_provider
          @shipping_provider = ShippingProvider.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def shipping_provider_params
          params.require(:shipping_provider).permit(:company, :rate)
        end
    end
  end
end