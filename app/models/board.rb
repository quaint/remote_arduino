class Board < ActiveRecord::Base
  
  default_scope :order => 'name'
  
  validates :name, :serial, :presence => true
  validates :name, :serial, :uniqueness => true
  
end
