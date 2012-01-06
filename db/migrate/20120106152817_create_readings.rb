class CreateReadings < ActiveRecord::Migration
  def self.up
    create_table :readings do |t|
      t.decimal :value
      t.integer :sensor_id

      t.timestamps
    end
  end

  def self.down
    drop_table :readings
  end
end
