class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.references :source_wallet, null: true
      t.references :target_wallet, null: true
      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :transaction_type, null: false
      t.string :description
      t.timestamps
    end
  end
end
