require 'spec_helper'

describe Tag do
  it 'should contain a name' do
    tag = Tag.new
    tag.should_not be_valid
    
    tag.name = 'some-name'
    tag.should be_valid
  end
  
  it 'may contain entries' do
    tag = Tag.new
    
    tag.entries.size.should == 0    
    tag.entries << (Entry.new :date => Date.current, :related_link => 'some-link', :percentage => 80.51)
    tag.entries.size.should == 1
  end
end
