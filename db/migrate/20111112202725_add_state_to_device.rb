class AddStateToDevice < ActiveRecord::Migration
  def self.up
    add_column :devices, :state, :boolean, :default => false
  end

  def self.down
    remove_column :devices, :state
  end
end
