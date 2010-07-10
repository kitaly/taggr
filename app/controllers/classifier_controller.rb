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
      response.xml { render :xml => @tags, :status => :ok }
    end
  end
  
  def create_guess
  end
  
  def guess
    classifier = BayesianClassifier.new  
    guesses = classifier.guess(params[:content])
    
    @result = Hash.new
    
    guesses.each do |guess|
      tag = Tag.find(guess[0].to_i)
      tag.entries << (Entry.new :date => params[:date], :related_link => params[:related_link], :percentage => guess[1])
      tag.save!
      
      @result[tag.name.to_s] = guess[1]
    end
    
    respond_to do |response|
      response.html
      response.xml { render :xml => @result, :status => :ok } 
    end
  end
end
