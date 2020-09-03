ActiveAdmin.register TmpHumLog do
  permit_params :humidity, :temperature

  index do
    selectable_column
    column :humidity
    column :temperature
    actions
  end

  filter :humidity
  filter :temperature

  form do |f|
    f.inputs do
      f.input :humidity
      f.input :temperature
    end
    f.actions
  end

end
