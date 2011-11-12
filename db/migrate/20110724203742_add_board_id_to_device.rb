class AddBoardIdToDevice < ActiveRecord::Migration
  def self.up
    add_column :devices, :board_id, :integer
  end

  def self.down
    remove_column :devices, :board_id
  end
end
