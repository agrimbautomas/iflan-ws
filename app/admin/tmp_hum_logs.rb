ActiveAdmin.register TmpHumLog do
  menu priority: 5

  permit_params :humidity, :temperature

  index do
    selectable_column
    column :created_at
    column :humidity do |tmphum|
      tmphum.humidity.to_s + "%"
		end
    column :temperature  do |tmphum|
      tmphum.temperature.to_s + "°"
    end
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
      row :humidity do
        tmphumlog.humidity.to_s + "%"
			end
      row :temperature do
        tmphumlog.temperature.to_s + "°"
			end
      row :created_at
    end
  end
end
