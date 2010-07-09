class ClassifierController < ApplicationController
  def train
    classifier = BayesianClassifier.new    
    
    params[:tags].split(',').each do |tag|
      classifier.train tag, params[:content]
    end
    
    respond_to do |response|
      response.html
      response.xml { head :ok }
    end
  end
  
  def create_train
    @tags = Tag.find(:all)
    
    respond_to do |response|
      response.html
      response.xml { render :xml => @tags, status => :ok }
    end
  end
end
