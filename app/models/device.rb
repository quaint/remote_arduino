class Device < ActiveRecord::Base
  
  default_scope :order => 'name'
  
  validates :name, :presence => true
  validates :name, :uniqueness => true
  validates :image_url, :format => {
    :with    => %r{\.(gif|jpg|png)$}i,
    :message => 'must be a URL for GIF, JPG or PNG image.'
  }
  
end
