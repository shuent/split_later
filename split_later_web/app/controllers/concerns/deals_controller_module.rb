module Concerns::DealsControllerModule
  # 共通処理
  class DealsControllerError < StandardError; end

  private

  def create_deal!(deal)
    Deal.transaction do
      deal.save!
      deal.users << current_user
      deal.users << find_partner(params[:partner_email])
    end
  end

  def find_partner(email)
    partner = User.find_by(email: email)
    raise DealsControllerError.new("can't find the email") if !partner
    raise DealsControllerError.new("can't be partner with your self") if partner == current_user
    raise DealsControllerError.new("partner already exist") if current_user.partners.include?(partner)
    partner
  end

  def error_message(e)
    render json: { message: e.message }
  end

end
