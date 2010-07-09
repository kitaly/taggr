require 'spec_helper'

describe Entry do
  it 'should contain date, percentage and link' do
    entry = Entry.new
    entry.should_not be_valid
    
    entry.date = Date.current
    entry.percentage = 80.51
    entry.related_link = 'http://www.some-site.com/123'
    
    entry.should be_valid
  end
end
