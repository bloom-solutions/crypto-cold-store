class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.integer :coin, null: false
      t.string :address, null: false
      t.string :code, null: false
      t.timestamps
    end

    add_index :addresses, [:coin, :address], unique: true
  end
end
