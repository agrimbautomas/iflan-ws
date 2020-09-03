class CreateTmpHumLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :tmp_hum_logs do |t|
      t.float :humidity, null: true
      t.float :temperature, null: true
      t.timestamps
    end
  end
end
