module LatestStockPrice
    class Error < StandardError; end
    class ApiError < Error; end
    class ConfigError < Error; end
  end