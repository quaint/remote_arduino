class Reading < ActiveRecord::Base
  
  belongs_to :sensor
  
  validates :value, :presence => true, :uniqueness => true
  
end
