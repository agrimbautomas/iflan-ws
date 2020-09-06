ActiveAdmin.register User do
  menu priority: 25

  permit_params :email, :password, :password_confirmation

  index do
    selectable_column
    column :email
    actions
  end

  filter :email

  form do |f|
    f.inputs do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end


  show do |user|
    attributes_table_for user do
      row :email
      row :sign_in_count
    end
	end

end
