class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :deal_id
      t.integer :borrower_id
      t.integer :lender_id
      t.float :price
      t.string :entry

      t.timestamps
    end
  end
end
