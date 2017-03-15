module Api
  class DealSerializer < ActiveModel::Serializer
    attributes :id, :partner, :sum
    def partner
      object.partner(current_user).try(:email)
    end

    def sum
      object.sum(current_user)
    end
  end
end