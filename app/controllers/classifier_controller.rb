class ClassifierController < ApplicationController
  def train
    classifier = BayesianClassifier.new    
    classifier.train params[:tags], params[:content]
  end
end
