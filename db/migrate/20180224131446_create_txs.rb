class CreateTxs < ActiveRecord::Migration[5.1]
  def change
    create_table :txs do |t|
      t.references :address, foreign_key: true
      t.decimal :amount
      t.integer :confirmations
      t.string :tx_id
      t.timestamps
    end

    add_index :txs, :confirmations
    add_index :txs, [:address_id, :tx_id], unique: true
  end
end
