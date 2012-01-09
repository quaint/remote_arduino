class AddKindAndSettingToDevices < ActiveRecord::Migration
  def self.up
    add_column :devices, :kind, :string
    add_column :devices, :setting, :string
  end

  def self.down
    remove_column :devices, :setting
    remove_column :devices, :kind
  end
end
