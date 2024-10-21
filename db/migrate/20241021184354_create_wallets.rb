class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.references :holder, polymorphic: true, null: false
      t.string :currency, null: false, default: 'USD'
      t.decimal :balance, precision: 15, scale: 2, default: 0
      t.timestamps
    end
  end
end
