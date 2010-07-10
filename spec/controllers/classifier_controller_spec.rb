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
        @classifier.should_receive(:train).once.with("#{@tag1.id}", 'some content to be trained here')

        post :train, :content => 'some content to be trained here', :related_link => 'some-link', :tags => "#{@tag1.id}"
      end
      
      it 'should accept more than one tag' do
        @classifier.should_receive(:train).once.with("#{@tag1.id}", 'some content to be trained here')
        @classifier.should_receive(:train).once.with("#{@tag2.id}", 'some content to be trained here')
        
        post :train, :content => 'some content to be trained here', :related_link => 'some-link', :tags => "#{@tag1.id},#{@tag2.id}"
      end
      
    end
  end
  
  context 'when the classifier should tag a content' do
    before(:each) do
      @classifier = mock("BayesianClassifier")
      BayesianClassifier.should_receive(:new).and_return(@classifier)        
    end
    
    it 'should associate to the right tag' do
      @classifier.should_receive(:guess).once.with('some content to be guessed').and_return([["#{@tag1.id}", 0.490674192302118]]);
      post :guess, :content => 'some content to be guessed', :date => @current_date, :related_link => 'some-link'
      
      @tag1.reload
      @tag1.entries.size.should == 1
      @tag1.entries[0].date == @current_date
      @tag1.entries[0].percentage == 0.490674192302118
      @tag1.entries[0].related_link == 'some-link'
    end
    
    it 'should associate with more than one tag if it is needed' do
      @classifier.should_receive(:guess).once.with('some content to be guessed').and_return([["#{@tag1.id}", 0.490674192302118], ["#{@tag2.id}", 0.51]]);
      post :guess, :content => 'some content to be guessed', :date => @current_date, :related_link => 'some-link'
      
      @tag1.reload
      @tag1.entries.size.should == 1
      @tag1.entries[0].date == @current_date
      @tag1.entries[0].percentage == 0.490674192302118
      @tag1.entries[0].related_link == 'some-link'
      
      @tag2.reload
      @tag2.entries.size.should == 1
      @tag2.entries[0].date == @current_date
      @tag2.entries[0].percentage == 0.51
      @tag2.entries[0].related_link == 'some-link'
    end
  end

end
