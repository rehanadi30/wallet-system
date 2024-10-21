module LatestStockPrice
    class Configuration
      attr_accessor :api_key, :base_url
  
      def initialize
        @base_url = 'https://latest-stock-price.p.rapidapi.com'
      end
    end
  
    class << self
      def configuration
        @configuration ||= Configuration.new
      end
  
      def configure
        yield(configuration)
      end
    end
  end