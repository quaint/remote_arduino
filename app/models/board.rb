class Board < ActiveRecord::Base
  
  has_many :devices
  default_scope :order => 'name'
  
  validates :name, :serial, :presence => true, :uniqueness => true
  validates :outputs, :presence => true
  validates_numericality_of :outputs, :only_integer => true
  
  def device(port)
    devices.each do |device|
      if device.port == port
        return device.id
      end
    end
  end
  
end
