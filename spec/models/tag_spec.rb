require 'spec_helper'

describe Tag do
  it 'should contain a name' do
    tag = Tag.new
    tag.should_not be_valid
    
    tag.name = 'some-name'
    tag.should be_valid
  end
end
