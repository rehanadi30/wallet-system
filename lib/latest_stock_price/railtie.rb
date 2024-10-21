module LatestStockPrice
    class Railtie < Rails::Railtie
      initializer 'latest_stock_price.configure' do |app|
        LatestStockPrice.configure do |config|
          config.api_key = Rails.application.credentials.rapid_api_key
        end
      end
    end
  end