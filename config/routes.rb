Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions, only: [:create]
      
      get 'wallet/balance', to: 'wallets#balance'
      post 'wallet/credit', to: 'wallets#credit'
      post 'wallet/debit', to: 'wallets#debit'
      post 'wallet/transfer', to: 'wallets#transfer'

      get 'stocks/price/:symbol', to: 'stocks#price'
      get 'stocks/prices', to: 'stocks#prices'
      get 'stocks/price_all', to: 'stocks#price_all'
    end
  end
end