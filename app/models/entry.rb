class Entry < ActiveRecord::Base
  belongs_to :tag
  validates_presence_of :date, :percentage, :related_link
end
