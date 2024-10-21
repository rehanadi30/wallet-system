class Wallet < ApplicationRecord
    belongs_to :holder, polymorphic: true
    has_many :source_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id'
    has_many :target_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id'
    
    validates :currency, presence: true
    validates :balance, presence: true, numericality: true
    
    def update_balance!
      credit_sum = target_transactions.sum(:amount)
      debit_sum = source_transactions.sum(:amount)
      update!(balance: credit_sum - debit_sum)
    end
    
    def sufficient_balance?(amount)
      balance >= amount
    end
  end