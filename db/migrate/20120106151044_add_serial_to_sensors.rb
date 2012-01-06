class AddSerialToSensors < ActiveRecord::Migration
  def self.up
    add_column :sensors, :serial, :text
  end

  def self.down
    remove_column :sensors, :serial
  end
end
