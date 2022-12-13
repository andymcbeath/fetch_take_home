class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :short_description
      t.integer :price_cents
      t.integer :receipt_id

      t.timestamps
    end
  end
end
