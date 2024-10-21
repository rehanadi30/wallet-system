class TransactionService
    class << self
      def credit(wallet:, amount:, description: nil)
        Transaction.create!(
          target_wallet: wallet,
          amount: amount,
          description: description,
          transaction_type: 'credit'
        )
      end
      
      def debit(wallet:, amount:, description: nil)
        Transaction.create!(
          source_wallet: wallet,
          amount: amount,
          description: description,
          transaction_type: 'debit'
        )
      end
      
      def transfer(from_wallet:, to_wallet:, amount:, description: nil)
        Transaction.create!(
          source_wallet: from_wallet,
          target_wallet: to_wallet,
          amount: amount,
          description: description,
          transaction_type: 'transfer'
        )
      end
    end
  end