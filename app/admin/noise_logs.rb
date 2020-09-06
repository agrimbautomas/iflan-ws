ActiveAdmin.register NoiseLog do
  menu priority: 5

	permit_params :created_at, :device_id

  index do
    selectable_column
    column :device_id
    column :created_at
    actions
  end

  filter :device_id
  filter :created_at

  form do |f|
    f.inputs do
      f.input :device_id
      f.input :created_at
    end
    f.actions
  end


  show do |noiselog|
    attributes_table_for noiselog do
      row :device_id
      row :created_at
    end
  end
end
