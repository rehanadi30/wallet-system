module LatestStockPrice
    class Client
      include HTTParty
      format :json
  
      def initialize(api_key = nil)
        @api_key = 'faf81cd2e7mshb927e20865a89c2p13a87bjsn2617f4089a7a'
        raise ConfigError, 'API key is required' unless @api_key
  
        # self.class.base_uri LatestStockPrice.configuration.base_url
        self.class.base_uri 'https://latest-stock-price.p.rapidapi.com'
        @options = {
          headers: {
            'X-RapidAPI-Key' => 'faf81cd2e7mshb927e20865a89c2p13a87bjsn2617f4089a7a',
            'X-RapidAPI-Host' => 'latest-stock-price.p.rapidapi.com'
          }
        }
      end
  
      # Get price for a single stock
      def price(symbol)
        response = self.class.get("/equities-search", @options.merge(query: { Search: symbol }))
        handle_response(response)
      end
  
      # Get prices for multiple stocks
      def prices(symbols)
        symbols_str = Array(symbols).join(',')
        
        response = self.class.get("/equities-enhanced", @options.merge(query: { Symbols: symbols_str }))
        
        handle_response(response)
      end
  
      # Get all available prices
      def price_all
        response = self.class.get("/any", @options)
        handle_response(response)
      end
  
      private
  
      def handle_response(response)
        case response.code
        when 200
          response.parsed_response
        when 401
          raise ApiError, 'Unauthorized - Invalid API key'
        when 404
          raise ApiError, 'Not Found - Invalid endpoint or stock symbol'
        when 429
          raise ApiError, 'Too Many Requests - Rate limit exceeded'
        else
          raise ApiError, "API Error: #{response.code} - #{response.body}"
        end
      end
    end
  end