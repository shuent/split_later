class Message < ApplicationRecord
  belongs_to :deal
  belongs_to :actor, class_name: "User", foreign_key: :actor_id
  validates :price, :borrow_lend, presence: true

  enum borrow_lend: { borrow: 0, lend: 1 }

  def status(current_user)
    if self.actor_id == current_user.id && self.borrow_lend == "borrow"
      "borrow"
    elsif self.actor_id != current_user.id && self.borrow_lend == "lend"
      "borrow"
    elsif self.actor_id == current_user.id && self.borrow_lend == "lend"
      "lend"
    elsif self.actor_id != current_user.id && self.borrow_lend == "borrow"
      "lend"
    end
  end
end
