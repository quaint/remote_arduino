class Device < ActiveRecord::Base
  
  belongs_to :board
  default_scope :order => 'name'
  
  validates :name, :presence => true, :uniqueness => true
  #validates_numericality_of :port, :greater_than => 0, :less_than_or_equal_to => Proc.new { |device| device.board.outputs }, :only_integer => true
  #validates_uniqueness_of :port, :scope => :board_id
  
end
