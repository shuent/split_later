class RmMessageDealidBorroweridAddActorId < ActiveRecord::Migration[5.0]
  def change
    remove_column :messages, :borrower_id, :integer
    remove_column :messages, :lender_id, :integer
    add_column :messages, :actor_id, :integer
    add_column :messages, :borrow_lend, :integer
  end

end
