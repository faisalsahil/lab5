ActiveAdmin.register User do

  permit_params :email

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    actions do |user|
      link_to 'Impersonate', impersonate_active_admin_user_path(user)
    end
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

end
