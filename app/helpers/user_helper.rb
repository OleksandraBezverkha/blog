module UserHelper
  def bound(provider)
    Identity.find_by(provider: provider, user_id: current_user.id)
  end
end