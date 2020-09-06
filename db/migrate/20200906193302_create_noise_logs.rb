class CreateNoiseLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :noise_logs do |t|
      t.integer :device_id, null: false
      t.timestamps
    end
  end
end
