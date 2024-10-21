class Transaction < ApplicationRecord
    belongs_to :source_wallet, class_name: 'Wallet', optional: true
    belongs_to :target_wallet, class_name: 'Wallet', optional: true
    
    validates :amount, presence: true, numericality: { greater_than: 0 }
    validates :transaction_type, presence: true, inclusion: { in: %w[credit debit transfer] }
    validate :valid_transaction_type
    validate :sufficient_balance
    
    after_create :update_wallet_balances
    
    private
    
    def valid_transaction_type
      case transaction_type
      when 'credit'
        errors.add(:source_wallet, 'must be nil for credit') if source_wallet.present?
        errors.add(:target_wallet, 'must be present for credit') if target_wallet.nil?
      when 'debit'
        errors.add(:source_wallet, 'must be present for debit') if source_wallet.nil?
        errors.add(:target_wallet, 'must be nil for debit') if target_wallet.present?
      when 'transfer'
        errors.add(:source_wallet, 'must be present for transfer') if source_wallet.nil?
        errors.add(:target_wallet, 'must be present for transfer') if target_wallet.nil?
      end
    end
    
    def sufficient_balance
      return unless source_wallet
      return if source_wallet.sufficient_balance?(amount)
      errors.add(:amount, 'insufficient balance')
    end
    
    def update_wallet_balances
      source_wallet&.update_balance!
      target_wallet&.update_balance!
    end
  end