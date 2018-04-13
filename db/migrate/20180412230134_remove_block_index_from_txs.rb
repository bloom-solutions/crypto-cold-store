class RemoveBlockIndexFromTxs < ActiveRecord::Migration[5.1]
  def change
    remove_column :txs, :block_index, :integer
  end
end
