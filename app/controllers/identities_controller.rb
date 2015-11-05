class IdentitiesController < ApplicationController
  def destroy
    @identity = Identity.find_by(user_id: current_user.id, provider: params[:provider] ).destroy
    flash[:notice] ="#{t(:successfully_destroyed_authentication)} #{@identity.provider.to_s.titleize}"
    redirect_to edit_user_registration_path
  end
end