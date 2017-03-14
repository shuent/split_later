class Message < ApplicationRecord
  belongs_to :deal
  belongs_to :actor, class_name: "User", foreign_key: :actor_id
  validates :price, :borrow_lend, presence: true

  def status(current_user)
    if self.actor_id == current_user.id && self.borrow_lend == 0
      "borrow"
    elsif self.actor_id != current_user.id && self.borrow_lend == 1
      "borrow"
    elsif self.actor_id == current_user.id && self.borrow_lend == 1
      "lend"
    elsif self.actor_id != current_user.id && self.borrow_lend == 0
      "lend"
    end
  end
end
