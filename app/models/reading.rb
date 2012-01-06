class Reading < ActiveRecord::Base
  
  belongs_to :sensor
  default_scope :order => 'created_at DESC'
  
  validates :value, :presence => true
  
end
