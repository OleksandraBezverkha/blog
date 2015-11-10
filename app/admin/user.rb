ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :username, :image
  # index do
  #   column :username
  #   column :email
  #   column :password
  #   column :password_confirmation
  #   column :image
  # end
  form do |f|
    f.input :username
    f.input :email
    f.input :password
    f.input :password_confirmation
    f.input :image
    f.actions
    end
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
