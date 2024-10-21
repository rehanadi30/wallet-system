class Team < ApplicationRecord
    has_one :wallet, as: :holder, dependent: :destroy
    validates :name, presence: true
    
    after_create :create_wallet
    
    private
    
    def create_wallet
      build_wallet(currency: 'USD').save!
    end
  end