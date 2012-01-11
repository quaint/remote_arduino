class Device < ActiveRecord::Base
  
  belongs_to :board
  default_scope :order => 'name'
  
  validates :name, :presence => true, :uniqueness => true
  validates_numericality_of :port, :greater_than => 0, :less_than_or_equal_to => Proc.new { |device| device.board.outputs }, :only_integer => true, :allow_nil => true
  validates_uniqueness_of :port, :scope => :board_id, :allow_nil => true
  validates_numericality_of :setting, :less_than_or_equal_to => 180
  validates_numericality_of :setting, :greater_than_or_equal_to => 0

  KINDS = {1 => :relay, 2 => :servo}

  def to_xml(options={})
    if options[:builder]
      build_xml(options[:builder])
    else
      xml = Builder::XmlMarkup.new
      xml.instruct!
      build_xml(xml)
    end
  end
  
  def working
    if state
      "on"
    else
      "off"
    end
  end
  
  def readable_kind
    KINDS[kind]
  end
  
  private
  
  def build_xml(xml)
    xml.device { |d| d.port( port ); d.kind( kind ); d.state( state ? 1 : 0 ); d.setting( setting ) }
  end
  
end
