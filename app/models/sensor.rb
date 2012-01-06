class Sensor < ActiveRecord::Base
  
  belongs_to :board
  default_scope :order => 'board_id'
  
  validates :name, :serial, :presence => true, :uniqueness => true
  
end
