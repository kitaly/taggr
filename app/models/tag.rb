class Tag < ActiveRecord::Base
  validates_presence_of :name
  has_many :entries
  
  def self.report_by_percentage(initial_date, end_date, min_percentage)
    Tag.all(
      :select => 'name, count(entries.id) as total',    
      :joins => :entries,
      :conditions => ["entries.date between ? and ? and entries.percentage >= ?", initial_date, end_date, min_percentage.to_f/100],
      :group => 'name'
      )
  end
end
