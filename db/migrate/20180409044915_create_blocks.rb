class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.integer :coin, null: false
      t.integer :height, null: false
      t.string :block_hash, null: false
      t.integer :confirmations
      t.timestamps
    end

    add_index :blocks, [:coin, :height]
    add_index :blocks, [:coin, :confirmations]
    add_index :blocks, [:coin, :block_hash], unique: true
  end
end
