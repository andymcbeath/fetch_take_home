class CreateReceipts < ActiveRecord::Migration[7.0]
  def change
    create_table :receipts do |t|
      t.string :retailer
      t.datetime :purchased_at
      t.integer :total_cents
      t.string :unique_id

      t.timestamps
    end
  end
end
