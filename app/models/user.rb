class User < ApplicationRecord
    has_secure_password
    has_one :wallet, as: :holder, dependent: :destroy
    
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
    
    after_create :create_wallet
    
    private
    
    def create_wallet
      build_wallet(currency: 'USD').save!
    end
  end