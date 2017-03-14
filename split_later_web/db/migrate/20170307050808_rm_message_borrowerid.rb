class RmMessageBorrowerid < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :borrower_id, :integer
  end
end
