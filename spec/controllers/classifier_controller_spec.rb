require 'spec_helper'

describe ClassifierController do
  before(:each) do
    @tag1 = Tag.new :name => 'tag1'; @tag1.save!
    @tag2 = Tag.new :name => 'tag2'; @tag2.save!
    
    @current_date = Date.current
  end
  
  context 'when the classifier is being trained' do
    it 'should show a html ui to let the user train the algorithm' do
      get :create_train
      
      assigns(:tags).size.should == 2
    end
    
    context 'and data is already provided' do
      before(:each) do
        @classifier = mock("BayesianClassifier")
        BayesianClassifier.should_receive(:new).and_return(@classifier)        
      end
      
      it 'should associate the content with the tag based on bayesian classifier algorithm' do
        @classifier.should_receive(:train).once.with('tag1', 'some content to be trained here')

        post :train, :content => 'some content to be trained here', :related_link => 'some-link', :date => @current_date, :tags => 'tag1'
      end
      
      it 'should accept more than one tag' do
        @classifier.should_receive(:train).once.with('tag1', 'some content to be trained here')
        @classifier.should_receive(:train).once.with('tag2', 'some content to be trained here')
        
        post :train, :content => 'some content to be trained here', :related_link => 'some-link', :date => @current_date, :tags => 'tag1,tag2'        
      end
      
    end
  end

end
