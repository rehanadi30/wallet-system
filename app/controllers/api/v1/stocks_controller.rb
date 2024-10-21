module Api
    module V1
      class StocksController < ApplicationController
        before_action :initialize_client
        
        def price
          result = @client.price(params[:symbol])
          render json: result
        rescue LatestStockPrice::Error => e
          render json: { error: e.message }, status: :unprocessable_entity
        end
  
        def prices
          symbols = params[:symbols].to_s.split(',')
          result = @client.prices(symbols)
          render json: result
        rescue LatestStockPrice::Error => e
          render json: { error: e.message }, status: :unprocessable_entity
        end
  
        def price_all
          result = @client.price_all
          render json: result
        rescue LatestStockPrice::Error => e
          render json: { error: e.message }, status: :unprocessable_entity
        end
  
        private
  
        def initialize_client
          @client = LatestStockPrice::Client.new
        end
      end
    end
  end