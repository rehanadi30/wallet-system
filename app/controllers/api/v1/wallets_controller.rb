module Api
    module V1
      class WalletsController < ApplicationController
        def balance
          render json: { balance: @current_user.wallet.balance }
        end
        
        def credit
          transaction = TransactionService.credit(
            wallet: @current_user.wallet,
            amount: params[:amount].to_d,
            description: params[:description]
          )
          render json: transaction
        end
        
        def debit
          transaction = TransactionService.debit(
            wallet: @current_user.wallet,
            amount: params[:amount].to_d,
            description: params[:description]
          )
          render json: transaction
        end
        
        def transfer
          target_wallet = Wallet.find(params[:target_wallet_id])
          transaction = TransactionService.transfer(
            from_wallet: @current_user.wallet,
            to_wallet: target_wallet,
            amount: params[:amount].to_d,
            description: params[:description]
          )
          render json: transaction
        end
      end
    end
  end