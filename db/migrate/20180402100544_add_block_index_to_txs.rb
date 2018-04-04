class AddBlockIndexToTxs < ActiveRecord::Migration[5.1]
  def change
    add_column :txs, :block_index, :integer
    add_index :txs, :block_index
  end
end
