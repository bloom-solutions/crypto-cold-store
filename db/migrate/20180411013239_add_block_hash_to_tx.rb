class AddBlockHashToTx < ActiveRecord::Migration[5.1]
  def change
    add_column :txs, :block_hash, :string
    add_index :txs, :block_hash
  end
end
