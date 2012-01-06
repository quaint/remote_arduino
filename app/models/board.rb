class Board < ActiveRecord::Base
  
  has_many :devices
  has_many :sensors
  default_scope :order => 'name'
  
  validates :name, :serial, :presence => true, :uniqueness => true
  validates :outputs, :presence => true
  validates_numericality_of :outputs, :only_integer => true
  
  def device_id_for_port(port)
    devices.find_by_port( port ).id if devices.find_by_port( port )
  end

end
