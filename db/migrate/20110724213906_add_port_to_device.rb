class AddPortToDevice < ActiveRecord::Migration
  def self.up
    add_column :devices, :port, :integer
  end

  def self.down
    remove_column :devices, :port
  end
end
