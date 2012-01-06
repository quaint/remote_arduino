class Sensor < ActiveRecord::Base
  
  belongs_to :board
  has_many :readings
  default_scope :order => 'board_id'
  
  validates :name, :serial, :presence => true, :uniqueness => true
  
end
