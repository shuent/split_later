class Deal < ApplicationRecord
  has_many :user_deals
  has_many :users, through: :user_deals
  has_many :messages, dependent: :delete_all

  def sum(current_user)
    sum = 0
    self.messages.each { |e|
      if e.actor == current_user
        if e.borrow_lend == 0 # borrower
          sum -= e.price
        else
          sum += e.price
        end
      else
        if e.borrow_lend == 0 # borrower
          sum += e.price
        else
          sum -= e.price
        end
      end
    }
    sum
  end

  def partner(current_user)
    self.users.where.not(id: current_user.id).first
  end
end
