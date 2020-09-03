ActiveAdmin.register TmpHumLog do
  permit_params :humidity, :temperature

  index do
    selectable_column
    column :created_at
    column :humidity
    column :temperature
    actions
  end

  filter :humidity
  filter :temperature
  filter :created_at

  form do |f|
    f.inputs do
      f.input :humidity
      f.input :temperature
    end
    f.actions
  end


  show do |tmphumlog|
    attributes_table_for tmphumlog do
      row :humidity
      row :temperature
      row :created_at
    end
  end
end
