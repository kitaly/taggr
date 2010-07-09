require 'spec_helper'

describe ClassifierController do
  before(:each) do
    #@tag1 = Tag.new :name => 'tag1'; @tag1.save!
    #@tag2 = Tag.new :name => 'tag2'; @tag2.save!
    
    @current_date = Date.current
    
    @classifier = mock("BayesianClassifier")
    BayesianClassifier.should_receive(:new).and_return(@classifier)
  end
  
  context 'when the classifier is being trained' do
    it 'should associate the content with the tag based on bayesign classifier algorithm' do
      @classifier.should_receive(:train).once.with('tag1', 'some content to be trained here')

      post :train, :content => 'some content to be trained here', :related_link => 'some-link', :date => @current_date, :tags => 'tag1'
    end
  end

end
